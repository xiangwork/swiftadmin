<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
/**
 * @mixin \think\Model
 */
class ApiRestful extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    // 字段修改器
    public function setSortAttr($value) 
    {
        if (is_empty($value)) {
            return self::count('id') + 1;
        }

        return $value;
    }
}
