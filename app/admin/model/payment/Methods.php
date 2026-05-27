<?php

namespace app\admin\model\payment;

use think\Model;

/**
 * Methods
 */
class Methods extends Model
{
    // 表名
    protected $name = 'payment_methods';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

}