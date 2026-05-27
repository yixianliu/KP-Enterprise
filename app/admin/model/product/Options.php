<?php

namespace app\admin\model\product;

use think\Model;

/**
 * Options
 */
class Options extends Model
{
    // 表名
    protected $name = 'product_options';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

}