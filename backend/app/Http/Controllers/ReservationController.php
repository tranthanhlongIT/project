<?php

namespace App\Http\Controllers;

use App\Models\Reservation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Guest;
use Illuminate\Database\Query\JoinClause;

class ReservationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = Guest::join('reservations', 'guests.id', '=', 'reservations.guest_id')
            ->where('reservations.active', '=', 0)
            ->join('reservation_room', 'reservations.id', '=', 'reservation_room.reservation_id')
            ->join('rooms', 'rooms.id', '=', 'reservation_room.room_id')
            ->select('reservations.id', 'guests.phone', 'rooms.number', 'reservations.room_price', 'reservations.check_in', 'reservations.check_out', 'reservations.total_stay', 'reservations.total_price')
            ->addSelect(DB::raw('CONCAT(guests.title, " ", guests.fname, " ", guests.lname) AS name'))
            ->orderByDesc('reservations.id')
            ->get();
        return response()->json($data);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Reservation $reservation)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Reservation $reservation)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Reservation $reservation)
    {
        //
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
}
