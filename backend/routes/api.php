<?php

use App\Http\Controllers\ImageController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\ReservationController;

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
Route::post('/upload-image', [ImageController::class, 'upload']);

Route::patch('/users/disable/{user}', [UserController::class, 'disable']);
Route::get('/users/prepare-data', [UserController::class, 'prepareData']);
Route::get('/rooms/prepare-data', [RoomController::class, 'prepareData']);
Route::get('/reservations/prepare-data', [ReservationController::class, 'prepareData']);

Route::get('/rooms/reservation-rooms', [RoomController::class, 'getReservationRooms']);
Route::apiResource('/reservations', ReservationController::class);
Route::apiResource('/users', UserController::class);
Route::apiResource('/rooms', RoomController::class);
