<?php

declare(strict_types=1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class Dictionary extends Model
{
    use SoftDelete;

    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

    // 字段修改器
    public function setSortAttr($value)
    {
        if (is_empty($value)) {
            return self::max('id') + 1;
        }

        return $value;
    }

    /**
     * 获取字典信息
     * @param string $value
     * @return array
     */
    public static function getValueList(string $value = '')
    {
        $list = [];

        // 默认只查询顶级
        $data = self::where([
            'pid' => 0,
            'value' => $value
        ])->find();

        if (!empty($data)) {
            $list = self::where('pid', $data['id'])->select();
        }

        return $list;
    }

    /**
     * 返回最小id
     */
    public static function minId(): int
    {
        return (int)self::where('pid', '0')->min('id');
    }
}
