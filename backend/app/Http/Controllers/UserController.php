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
    public function index()
    {
        $data = User::with('role:id,name')
            ->select('id', 'email', 'image', 'active', 'role_id', 'gender', 'address', 'fname', 'lname', 'phone')
            ->get();
        return response()->json($data);
    }

    public function store(Request $request)
    {
        $this->validation();

        $data = $request->all();
        $data['password'] = bcrypt($request->password);
        $data['image'] = $this->uploadImage($request);

        $user = User::create($data);

        return response()->json([
            'id' => $user->id,
            'status' => true,
        ]);
    }

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

    public function prepareData()
    {
        $roles = DB::table('roles')->select('id', 'name')->get();

        return response()->json([
            'roles' => $roles
        ]);
    }

    private function validation(?User $user = null)
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
            'phone' => ['bail', 'required', 'digits:10', 'numeric']
        ];

        $validator = Validator::make(request()->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'message' => $validator->messages()->first()
            ], 400)->throwResponse();
        }
    }

    // Private function //

    private function uploadImage(Request $request)
    {
        if ($request->hasfile('image')) {
            $image = request()->file('image');
            $fileName = $image->getClientOriginalName();
            $image->storeAs('images', $fileName);
        }

        return $fileName ?? null;
    }
}
