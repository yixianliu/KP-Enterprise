<?php

namespace app\admin\model;

use think\Model;

/**
 * Appt
 */
class Appt extends Model
{
    // 表名
    protected $name = 'appt';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;


    public function getContentAttr($value): string
    {
        return !$value ? '' : htmlspecialchars_decode($value);
    }
}