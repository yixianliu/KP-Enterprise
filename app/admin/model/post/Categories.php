<?php

namespace app\admin\model\post;

use think\Model;

/**
 * Categories
 */
class Categories extends Model
{
    // 表名
    protected $name = 'post_categories';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

}