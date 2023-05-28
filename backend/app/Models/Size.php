<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Size extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'sizes';
    protected $primaryKey = 'id';
    protected $guarded = [];

    public function rooms()
    {
        return $this->hasMany(Room::class);
    }
}
