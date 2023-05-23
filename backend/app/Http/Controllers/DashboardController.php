<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Reservation;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function roomData()
    {
        $totalRooms = DB::table('rooms')->count();

        $reservedRooms = DB::table('rooms')
            ->join('reservation_room', 'rooms.id', '=', 'reservation_room.room_id')
            ->join('reservations', 'reservations.id', '=', 'reservation_room.reservation_id')
            ->where('reservations.active', 1)
            ->groupBy('rooms.id')
            ->get()
            ->count();

        $vacantRooms = $totalRooms - $reservedRooms;

        return response()->json([
            'totalRooms' => $totalRooms,
            'reservedRooms' => $reservedRooms,
            'vacantRooms' => $vacantRooms
        ]);
    }

    public function barChartData()
    {
        $currentYear = date('Y');
        $currentMonth = date('n');

        $totalDayInMonth = cal_days_in_month(CAL_GREGORIAN, $currentMonth, $currentYear);
        $daysInMonth = range(1, $totalDayInMonth);

        $data = [];

        for ($day = 1; $day <= $totalDayInMonth; $day++) {
            $totalPriceByDay = DB::table('reservations')
                ->whereDate('start_date', $currentYear)
                ->whereMonth('start_date', $currentMonth)
                ->whereDay('start_date', $day)
                ->sum('total_price');

            $data[] = $totalPriceByDay;
        }

        $maxValue = max($data);

        return response()->json([
            'data' => $data,
            'max_value' => $maxValue,
            'days_in_month' => $daysInMonth
        ]);
    }

    public function pieChartData()
    {
        $currentDate = Carbon::now()->format('Y-m-d');

        $reservationsByDay = DB::table('reservations')
            ->whereDate('start_date', $currentDate)
            ->get();

        $countByStatus = [0, 0, 0]; // Index array to store the count by status

        foreach ($reservationsByDay as $reservation) {
            if ($reservation->status === 'Reserved') {
                $countByStatus[0]++;
            } elseif ($reservation->status === 'Cancel') {
                $countByStatus[1]++;
            } elseif ($reservation->status === 'Pending') {
                $countByStatus[2]++;
            }
        }

        return response()->json($countByStatus);
    }
}
