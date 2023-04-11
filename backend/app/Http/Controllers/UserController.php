<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = DB::table('users')
            ->select('users.id', 'users.email', 'users.image', 'roles.name as role', 'users.active')
            ->join('roles', 'roles.id', '=', 'users.role_id')
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
        try {
            if (isset($request->image) && $request->image != "") {
                $file = request()->file('image');
                $fileName = $file->getClientOriginalName();
                $file->storeAs('images', $fileName);
            }

            if ($this->validate($request)) {
                $data = $request->all();
                $data['password'] = bcrypt($request->password);
                $data['image'] = $fileName;
            }

            $this->checkEmailExist($request);

            User::create($data);

            return response()->json([
                'status' => true,
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage(),
            ]);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }

    public function prepareData() {
        $roles = DB::table('roles')->select('id', 'name')->get();

        return response()->json([
            'roles' => $roles
        ]);
    }

    public function validate(Request $request) {
        $passwordValidation = Password::min(8)
            ->letters()
            ->mixedCase()
            ->numbers()
            ->symbols()
            ->uncompromised();

        $validate = Validator::make($request->all(), [
            'name' => ['bail', 'required', 'max:30'],
            'email' => ['bail', 'required', 'email', 'unique:users'],
            'password' => ['bail', 'required', $passwordValidation],
            'role_id' => ['bail', 'required'],
            'active' => ['bail', 'required'],
            'fname' => ['bail', 'required'],
            'lname' => ['bail', 'required'],
            'gender' => ['bail', 'required'],
            'phone' => ['required']
        ]);

        return $validate;
    }

    public function checkEmailExist(Request $request) {
        $user = User::where('email', '=', $request->email)->count();

        if ($user > 0) {
            return response()->json([
                'status' => false,
                'message' => 'User already existed'
            ]);
        }
    }
}
