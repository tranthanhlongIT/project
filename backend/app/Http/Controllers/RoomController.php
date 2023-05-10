<?php

namespace App\Http\Controllers;

use App\Models\Floor;
use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class RoomController extends Controller
{
    public function index()
    {
        $data = Floor::with('children:number as id,number as name,floor_id')->get();

        return response()->json($data);
    }

    public function getReservationRooms(Request $request)
    {
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
            )->wherePivot('occupied_date', '=', $request->date);
        }, 'rooms.reservations.guest', 'rooms.images:id,room_id,name', 'rooms.type:id,name', 'rooms.size:id,name', 'rooms.floor:id,name'])->get();

        return response()->json($data);
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
        $room = Room::with([
            'type:id,name', 'images:id,name,room_id', 'size:id,name,icon',
            'floor:id,name', 'services:id,name,icon'
        ])
            ->where('number', '=', $number)
            ->first();

        return response()->json($room);
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

    // Private function //

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
