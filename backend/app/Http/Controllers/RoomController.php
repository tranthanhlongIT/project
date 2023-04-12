<?php

namespace App\Http\Controllers;

use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RoomController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = DB::table('rooms')->select('rooms.id', 'rooms.name', 'types.name as type')
            ->join('types', 'types.id', '=', 'rooms.type_id')
            ->get();

        return response()->json([
            'data' => $data
        ]);
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
    public function show($id)
    {
        $data = DB::table('types')
            ->select('rooms.name', 'types.name as type', 'rooms.description', 'rooms.size', 'rooms.size', 'rooms.price', 'images.name as image')
            ->join('rooms', 'types.id', '=', 'rooms.type_id')
            ->join('images', 'rooms.id', '=', 'images.room_id')
            ->where('rooms.id', '=', $id)->get();

        return response()->json([
            'data' => $data
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Room $room)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Room $room)
    {
        //
    }
}
