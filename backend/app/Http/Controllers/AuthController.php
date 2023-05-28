<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use App\Models\User;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        try {
            $data = $request->validate([
                'email' => 'email|required',
                'password' => 'required'
            ]);

            $this->validateUser($data);

            $token = auth()->user()->createToken('api_token')->accessToken;

            return response()->json([
                'status' => true,
                'current_user' => auth()->user(),
                'token' => 'Bearer ' . $token
            ]);
        } catch (ValidationException $e) {

            return response()->json([
                'status' => $e->status,
                'message' => $e->errors(),
            ]);
        }
    }

    public function logout()
    {
        try {
            auth()->user()->token()->revoke();

            return response()->json([
                'status' => true
            ]);
        } catch (\Exception $e) {

            return response()->json([
                'status' => false
            ]);
        }
    }

    // =====================================================================
    // Private function area 
    // ======================================================================

    private function validateUser($data)
    {
        if (!User::where('email', $data['email'])->exists()) {
            return response()->json([
                'status' => false,
                'message' => "User doesn't exist"
            ])->throwResponse();
        }

        if (!auth()->attempt($data)) {
            return response()->json([
                'status' => false,
                'message' => 'Email or password does not match'
            ])->throwResponse();;
        }

        if (!auth()->user()->active) {
            return response()->json([
                'status' => false,
                'message' => 'User not authorized'
            ])->throwResponse();;
        }
    }
}
