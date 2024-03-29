<?php

namespace App\Http\Controllers;


use App\Models\Floor;
use App\Models\Room;
use App\Models\Service;
use App\Models\Size;
use App\Models\Type;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class RoomController extends Controller
{
    public function index()
    {
        try {
            $data = Floor::with('children:number as id,number as name,floor_id')->get();

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

    public function getReservationRooms(Request $request)
    {
        try {
            $data = Floor::with(['rooms.reservations' => function ($query) use ($request) {
                $query->select(
                    'reservations.id',
                    'reservations.guest_id',
                    'reservations.total_stay',
                    'reservations.total_price',
                    'reservations.check_in',
                    'reservations.check_out',
                    'reservations.start_date',
                    'reservations.end_date',
                    'reservations.status',
                    'reservations.active'
                )->where('reservations.active', '=', 1)->wherePivot('occupied_date', '=', $request->date);
            }, 'rooms.reservations.guest', 'rooms.images:id,room_id,name', 'rooms.type:id,name', 'rooms.size:id,name', 'rooms.floor:id,name'])->get();

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

        $data = $request->except(['services', 'images']);
        $services = collect(json_decode($request->services))->pluck('id');
        $room = Room::create($data);
        $this->uploadImage($request, $room);
        $room->services()->attach($services);

        return response()->json([
            'status' => true,
        ]);
    }

    public function show($number)
    {
        try {
            $data = Room::with([
                'type:id,name', 'images:id,name,room_id', 'size:id,name,icon',
                'floor:id,name', 'services:id,name,icon'
            ])
                ->where('number', '=', $number)
                ->first();

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

    public function update(Request $request, Room $room)
    {
        $this->validation($room);

        $data = $request->except(['services', 'images']);
        $services = collect(json_decode($request->services))->pluck('id');
        $room->update($data);
        $this->uploadImage($request, $room);
        $room->services()->sync($services);

        return response()->json([
            'status' => true,
        ]);
    }

    public function destroy(Room $room)
    {
        $room->delete();

        return response()->json([
            'status' => true,
        ]);
    }

    public function prepareData()
    {
        $types = Type::select('id', 'name')->get();
        $sizes = Size::select('id', 'name', 'icon')->get();
        $floors = Floor::select('id', 'name')->get();
        $services = Service::select('id', 'name', 'icon')->get();

        return response()->json([
            'types' => $types,
            'sizes' => $sizes,
            'floors' => $floors,
            'services' => $services
        ]);
    }

    // =====================================================================
    // Private function area 
    // ======================================================================

    private function validation(Room $room = null)
    {
        $rules = [
            'type_id' => ['bail', 'required'],
            'floor_id' => ['bail', 'required'],
            'size_id' => ['bail', 'required'],
            'number' => ['bail', 'required', Rule::unique('rooms')->ignore($room)],
            'name' => ['bail', 'required', 'max:30'],
            'price' => ['bail', 'required', 'numeric'],
            'services' => ['bail', 'required'],
        ];

        $validator = Validator::make(request()->all(), $rules);

        if ($validator->fails()) {

            return response()->json([
                'message' => $validator->messages()->first()
            ], 400)->throwResponse();
        }
    }

    private function uploadImage(Request $request, Room $room)
    {
        if ($request->hasFile('images')) {
            $room->images()->delete();

            foreach ($request->file('images') as $image) {
                $fileName = $image->getClientOriginalName();
                $this->storeImage($image, $fileName);
                $room->images()->create([
                    'name' => $fileName
                ]);
            }
        }
    }

    private function storeImage($image, $fileName)
    {
        if (!Storage::exists('images/' . $fileName)) {
            $image->storeAs('images', $fileName);
        }
    }
}
