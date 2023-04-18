<?php

namespace App\Http\Controllers;

use App\Models\Floor;
use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

class RoomController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = Floor::with('children:number as id,number as name,floor_id')->get();

        return response()->json($data);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $this->validation();

            $data = $request->except(['services', 'images']);
            $services = collect(json_decode($request->services))->pluck('id');
            $room = Room::create($data);
            $this->uploadImage($request, $room);
            $room->services()->attach($services);

            return response()->json([
                'status' => true,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
                'data' => $request->services
            ]);
        }

    }

    /**
     * Display the specified resource.
     */
    public function show($number)
    {
        $room = Room::with(['type:id,name', 'images:id,name,room_id', 'size:id,name',
            'floor:id,name', 'services:id,name,icon'])
            ->where('number', '=', $number)
            ->first();

        return response()->json($room);
    }

    /**
     * Update the specified resource in storage.
     */
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

    /**
     * Remove the specified resource from storage.
     */
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

    public function validation(Room $room = null)
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

    public function uploadImage(Request $request, Room $room)
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

    public function storeImage($image, $fileName)
    {
        if (!Storage::exists('images/' . $fileName)) {
            $image->storeAs('images', $fileName);
        }
    }
}
