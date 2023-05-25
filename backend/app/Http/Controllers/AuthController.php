<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => 'email|required',
            'password' => 'required'
        ]);

        if (!auth()->attempt($data)) {
            return response()->json([
                'status' => false,
                'message' => 'Email or password does not match'
            ]);
        }

        if (!auth()->user()->active) {
            return response()->json([
                'status' => false,
                'message' => 'User not authorized'
            ]);
        }

        $token = auth()->user()->createToken('api token')->accessToken;

        return response()->json([
            'status' => true,
            'message' => 'Login successful',
            'current_user' => auth()->user(),
            'token' => 'Bearer ' . $token
        ]);
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
}
