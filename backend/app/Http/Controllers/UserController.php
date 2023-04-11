<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;
use Illuminate\Support\Facades\File;

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
        if ($this->validation($request)) {
            $data = $request->all();
            $data['password'] = bcrypt($request->password);
            $data['image'] = $this->uploadImage($request);
        }

        User::create($data);

        return response()->json([
            'status' => true,
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $roles = DB::table('roles')->select('id', 'name')->get();

        return response()->json([
            'roles' => $roles
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    public function validation(Request $request)
    {
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

    public function uploadImage(Request $request)
    {
        if (!empty($request->image)) {
            $file = request()->file('image');
            $fileName = $file->getClientOriginalName();
            $file->storeAs('images', $fileName);
        }

        return $fileName ?? null;
    }

    public function getImage($filename)
    {
        $path = storage_path() . '/app/images/' . $filename;

        if (!File::exists($path)) {
            return response()->json(['message' => 'Image not found.'], 404);
        }

        $file = File::get($path);
        $type = File::mimeType($path);

        $response = Response::make($file, 200);
        $response->header("Content-Type", $type);

        return $response;
    }
}
