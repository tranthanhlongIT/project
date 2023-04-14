<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\Password;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = DB::table('users')
            ->select('users.id', 'users.email', 'users.image', 'roles.name as role',
                'users.active', 'users.role_id', 'users.gender', 'users.address',
                'users.fname', 'users.lname', 'users.phone')
            ->join('roles', 'roles.id', '=', 'users.role_id')
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
        $data['password'] = bcrypt($request->password);
        $data['image'] = $this->uploadImage($request);

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

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, User $user)
    {
        $this->validation($user);

        $data = $request->all();
        $data['image'] = $this->uploadImage($request) ?? $user->image;

        $user->update($data);

        return response()->json([
            'status' => true,
        ]);
    }

    public function disable(User $user)
    {
        $user->update(['active' => false]);

        return response()->json([
            'status' => true,
        ]);
    }

    public function validation(?User $user = null)
    {
        $passwordValidation = Password::min(8)
            ->letters()
            ->mixedCase()
            ->numbers()
            ->symbols()
            ->uncompromised();

        $rules = [
            'fname' => ['bail', 'required', 'max:30'],
            'lname' => ['bail', 'required', 'max:30'],
            'email' => ['bail', Rule::excludeIf(isset($user)), 'required', 'email', 'unique:users'],
            'password' => ['bail', Rule::excludeIf(isset($user)), 'required', $passwordValidation],
            'role_id' => ['bail', 'required'],
            'active' => ['bail', 'required'],
            'gender' => ['bail', 'required'],
            'phone' => ['bail', 'required', 'min_digits:10', 'max_digits:10', 'numeric']
        ];

        $validator = Validator::make(request()->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'message' => $validator->messages()->first()
            ], 400)->throwResponse();
        }
    }

    public function uploadImage(Request $request)
    {
        if ($request->hasfile('image')) {
            $file = request()->file('image');
            $fileName = $file->getClientOriginalName();
            $file->storeAs('images', $fileName);
        }

        return $fileName ?? null;
    }

    public function prepareData()
    {
        $roles = DB::table('roles')->select('id', 'name')->get();

        return response()->json([
            'roles' => $roles
        ]);
    }
}
