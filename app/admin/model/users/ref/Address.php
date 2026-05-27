<?php

namespace app\admin\model\users\ref;

use think\Model;

/**
 * Address
 */
class Address extends Model
{
    // 表名
    protected $name = 'users_ref_address';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

    // 追加属性
    protected $append = [
        'city_text',
    ];

    protected static function onAfterInsert($model): void
    {
        if (is_null($model->weigh)) {
            $pk = $model->getPk();
            if (strlen($model[$pk]) >= 19) {
                $model->where($pk, $model[$pk])->update(['weigh' => $model->count()]);
            } else {
                $model->where($pk, $model[$pk])->update(['weigh' => $model[$pk]]);
            }
        }
    }

    public function getCityAttr($value): array
    {
        if ($value === '' || $value === null) return [];
        if (!is_array($value)) {
            return explode(',', $value);
        }
        return $value;
    }

    public function setCityAttr($value): string
    {
        return is_array($value) ? implode(',', $value) : $value;
    }

    public function getCityTextAttr($value, $row): string
    {
        if ($row['city'] === '' || $row['city'] === null) return '';
        $cityNames = \think\facade\Db::name('area')->whereIn('id', $row['city'])->column('name');
        return $cityNames ? implode(',', $cityNames) : '';
    }

    public function refUser(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\User::class, 'ref_user_id', 'id');
    }
}