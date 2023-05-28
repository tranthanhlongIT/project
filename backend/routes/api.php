<?php

use App\Http\Controllers\DashboardController;
use App\Http\Controllers\GuestController;
use App\Http\Controllers\ImageController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\ReservationController;
use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Route;

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

Route::post('/admin/login', [AuthController::class, 'login']);
Route::get('/storage/app/images/{filename}', [ImageController::class, 'index']);

Route::middleware('auth:api')->group(function () {

    Route::post('/admin/logout', [AuthController::class, 'logout']);
    Route::post('/upload-image', [ImageController::class, 'upload']);

    Route::get('/dashboard/room-data', [DashboardController::class, 'roomData']);
    Route::get('/dashboard/bar-chart-data', [DashboardController::class, 'barChartData']);
    Route::get('/dashboard/pie-chart-data', [DashboardController::class, 'pieChartData']);

    Route::get('/reservations/prepare-data', [ReservationController::class, 'prepareData']);
    Route::get('/reservations/get-disabled-dates/{id}', [ReservationController::class, 'getDisabledDate']);
    Route::patch('/reservations/disable/{reservation}', [ReservationController::class, 'disable']);

    Route::get('/users/prepare-data', [UserController::class, 'prepareData']);
    Route::patch('/users/disable/{user}', [UserController::class, 'disable']);

    Route::get('/rooms/prepare-data', [RoomController::class, 'prepareData']);
    Route::get('/rooms/reservation-rooms', [RoomController::class, 'getReservationRooms']);

    Route::apiResource('/reservations', ReservationController::class);
    Route::apiResource('/users', UserController::class);
    Route::apiResource('/rooms', RoomController::class);
    Route::apiResource('/guests', GuestController::class);
});
