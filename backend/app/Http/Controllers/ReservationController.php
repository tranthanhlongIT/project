<?php

namespace App\Http\Controllers;

use App\Models\Guest;
use App\Models\Reservation;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Validator;

class ReservationController extends Controller
{
    public function index()
    {
        try {
            $data = Guest::join('reservations', 'guests.id', '=', 'reservations.guest_id')
                ->where('reservations.active', '=', 0)
                ->join('reservation_room', 'reservations.id', '=', 'reservation_room.reservation_id')
                ->join('rooms', 'rooms.id', '=', 'reservation_room.room_id')
                ->select(
                    'reservations.id',
                    'guests.phone',
                    'rooms.number',
                    'reservations.room_price',
                    'reservations.check_in',
                    'reservations.check_out',
                    'reservations.total_stay',
                    'reservations.total_price'
                )
                ->addSelect(DB::raw('CONCAT(guests.title, " ", guests.fname, " ", guests.lname) AS name'))
                ->where('reservations.status', '!=', 'Cancel')
                ->groupBy('reservations.id')
                ->orderByDesc('reservations.id')
                ->get();

            return response()->json([
                'status' => true,
                'data' => $data
            ]);
        } catch (\Exception $e) {

            return response()->json([
                'status' => false,
                'message' => $e->getMessage(),
            ]);
        }
    }

    public function store(Request $request)
    {
        $this->validation();

        $data = $request->except(['room_id']);

        $reservation = Reservation::create($data);

        for ($i = 0; $i < $request->total_stay; $i++) {
            $date = Carbon::createFromFormat('Y-m-d', $request->start_date);
            $occupiedDate = $date->addDays($i)->format('Y-m-d');
            $reservation->rooms()->attach($request->room_id, ['occupied_date' => $occupiedDate]);
        }

        return response()->json([
            'status' => true,
            'id' => $reservation->id
        ]);
    }

    public function update(Request $request, Reservation $reservation)
    {
        $this->validation($reservation);

        $data = $request->except(['room_id']);
        if (!empty($data['check_out'])) {
            $data['active'] = false;
        }

        $endDate = $reservation->end_date;

        $reservation->update($data);

        if ($request->end_date != $endDate) {
            for ($i = 0; $i < $request->total_stay; $i++) {
                $date = Carbon::createFromFormat('Y-m-d', $request->start_date);
                $occupiedDate = $date->addDays($i)->format('Y-m-d');
                $reservation->rooms()->sync($request->room_id, ['occupied_date' => $occupiedDate]);
            }
        }

        return response()->json([
            'status' => true,
        ]);
    }

    public function disable(Reservation $reservation)
    {
        $reservation->update([
            'status' => 'Cancel',
            'active' => false
        ]);

        return response()->json([
            'status' => true,
        ]);
    }

    public function checkOut(Request $request, Reservation $reservation)
    {
        $reservation->update([
            'check_out' => $request->check_out,
            'active' => false
        ]);

        return response()->json([
            'status' => true,
        ]);
    }

    public function prepareData()
    {
        $types = DB::table('types')->select('id', 'name')->get();
        $sizes = DB::table('sizes')->select('id', 'name', 'icon')->get();
        $floors = DB::table('floors')->select('id', 'name')->get();
        $services = DB::table('services')->select('id', 'name', 'icon')->get();

        return response()->json([
            'types' => $types,
            'sizes' => $sizes,
            'floors' => $floors,
            'services' => $services
        ]);
    }

    public function getDisabledDate(Request $request, $id)
    {
        if ($request->action == 'add')
            $dates = $this->disableDateForNewReservation($id);
        else $dates = $this->disableDateForUpdateReservation($id, $request->reservation);

        return response()->json($dates);
    }

    // =====================================================================
    // Private function area 
    // ======================================================================

    private function disableDateForNewReservation($id)
    {
        $dates = DB::table('reservations')
            ->where('active', '=', '1')
            ->join('reservation_room', 'reservations.id', '=', 'reservation_room.reservation_id')
            ->select('occupied_date')
            ->where('room_id', '=', $id)->get();

        return $dates;
    }

    private function disableDateForUpdateReservation($id, $reservationId)
    {
        $dates = DB::table('reservations')
            ->where('active', '=', '1')
            ->join('reservation_room', 'reservations.id', '=', 'reservation_room.reservation_id')
            ->where('reservations.id', '!=', $reservationId)
            ->select('occupied_date')
            ->where('room_id', '=', $id)->get();

        return $dates;
    }

    private function validation(?Reservation $reservation = null)
    {
        $rules = [
            'guest_id' => ['bail', Rule::excludeIf(isset($reservation)), 'required'],
            'room_id' => ['bail', 'required'],
            'room_price' => ['bail', Rule::excludeIf(isset($reservation)), 'required'],
            'total_stay' => ['bail', 'required'],
            'total_price' => ['bail', 'required'],
            'status' => ['bail', 'required'],
            'active' => ['bail', 'required'],
        ];

        $validator = Validator::make(request()->all(), $rules);

        if ($validator->fails()) {

            return response()->json([
                'message' => $validator->messages()->first()
            ], 400)->throwResponse();
        }
    }
}
