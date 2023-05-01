<?php

namespace App\Http\Controllers;

use App\Models\Guest;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class GuestController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = Guest::select('id', 'title', 'fname', 'lname', 'phone', 'email', 'address', 'description')
            ->addSelect(DB::raw('CONCAT(guests.fname, " ", guests.lname) AS name'))
            ->get();

        return response()->json($data);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $this->validation();

        $data = $request->all();

        $guest = Guest::create($data);

        return response()->json([
            'id' => $guest->id,
            'status' => true,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Guest $guest)
    {
        $this->validation();

        $data = $request->all();

        $guest->update($data);

        return response()->json([
            'status' => true,
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Guest $guest)
    {
        $guest->delete();

        return response()->json([
            'status' => true,
        ]);
    }

    public function validation(?Guest $guest = null)
    {
        $rules = [
            'fname' => ['bail', 'required', 'max:30'],
            'lname' => ['bail', 'required', 'max:30'],
            'phone' => ['bail', 'required', 'digits:10', 'numeric'],
            'email' => ['bail', Rule::excludeIf(isset($guest)), 'email', 'unique:users'],
        ];

        $validator = Validator::make(request()->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'message' => $validator->messages()->first()
            ], 400)->throwResponse();
        }
    }
}
