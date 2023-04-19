<?php

namespace App\Http\Controllers;

use App\Models\Reservation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Room;

class ReservationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

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
