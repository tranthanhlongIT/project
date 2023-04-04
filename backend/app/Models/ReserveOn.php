<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReserveOn extends Model
{
    use HasFactory;

    protected $table = 'reserve_ons';
    protected $primaryKey = 'id';
    protected $guarded = [];
}
