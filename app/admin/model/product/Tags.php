<?php

namespace app\admin\model\product;

use think\Model;

/**
 * Tags
 */
class Tags extends Model
{
    // 表名
    protected $name = 'product_tags';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

}