<?php

namespace App\Http\Controllers;

use App\Models\Guest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class GuestController extends Controller
{
    public function index()
    {
        try {
            $data = Guest::select('id', 'title', 'fname', 'lname', 'phone', 'email', 'address', 'description')
                ->addSelect(DB::raw('CONCAT(guests.fname, " ", guests.lname) AS name'))
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

        $data = $request->all();

        $guest = Guest::create($data);

        return response()->json([
            'id' => $guest->id,
            'status' => true,
        ]);
    }

    public function update(Request $request, Guest $guest)
    {
        $this->validation();

        $data = $request->all();

        $guest->update($data);

        return response()->json([
            'status' => true,
        ]);
    }

    public function destroy(Guest $guest)
    {
        $guest->delete();

        return response()->json([
            'status' => true,
        ]);
    }

    // =====================================================================
    // Private function area 
    // ======================================================================

    private function validation(?Guest $guest = null)
    {
        $rules = [
            'fname' => ['bail', 'required', 'max:30'],
            'lname' => ['bail', 'required', 'max:30'],
            'phone' => ['bail', 'required', 'digits:10', 'numeric'],
        ];

        $validator = Validator::make(request()->all(), $rules);

        if ($validator->fails()) {

            return response()->json([
                'message' => $validator->messages()->first()
            ], 400)->throwResponse();
        }
    }
}
