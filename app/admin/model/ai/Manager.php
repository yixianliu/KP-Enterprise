<?php

namespace app\admin\model\ai;

use think\Model;

/**
 * Manager
 */
class Manager extends Model
{
    // 表名
    protected $name = 'ai_manager';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;


    public function getPricePerTokenAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }
}