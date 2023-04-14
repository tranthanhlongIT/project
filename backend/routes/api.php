<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\RoomController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/storage/app/images/{filename}', [ImageController::class, 'index']);

Route::patch('/users/disable/{user}', [UserController::class, 'disable']);

Route::get('/users/preparedata', [UserController::class, 'prepareData']);
Route::get('/rooms/preparedata', [RoomController::class, 'prepareData']);
Route::apiResource('/users', UserController::class);
Route::apiResource('/rooms', RoomController::class);
