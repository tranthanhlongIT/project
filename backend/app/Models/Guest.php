<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Guest extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'guests';
    protected $primaryKey = 'id';
    protected $guarded = [];

    protected $hidden = [
        'created_at',
        'updated_at',
        'deleted_at'
    ];

    public function reservations()
    {
        return $this->hasMany(Reservation::class);
    }
}
