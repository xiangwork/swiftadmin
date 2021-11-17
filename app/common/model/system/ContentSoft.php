<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;

/**
 * @mixin \think\Model
 */
class ContentSoft extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
}
