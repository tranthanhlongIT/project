<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Reservation;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function barChartData()
    {
        $currentYear = date('Y');
        $currentMonth = date('n');

        $totalDayInMonth = cal_days_in_month(CAL_GREGORIAN, $currentMonth, $currentYear);
        $daysInMonth = range(1, $totalDayInMonth);

        $data = [];

        for ($day = 1; $day <= $totalDayInMonth; $day++) {
            $totalPriceByDay = DB::table('reservations')
                ->whereYear('start_date', $currentYear)
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
        $currentYear = date('Y');
        $currentMonth = date('n');
        $currentDay = date('j');

        $reservationsByDay = DB::table('reservations')
            ->whereYear('created_at', $currentYear)
            ->whereMonth('created_at', $currentMonth)
            ->whereDay('created_at', $currentDay)
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
