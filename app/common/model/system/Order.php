<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;

/**
 * @mixin \think\Model
 */
class Order extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    // 关联插件
    public function plugin()
    {
        return $this->hasOne(Plugin::class,'id','pid');
    }

    // 关联插件
    public function template()
    {
        return $this->hasOne(Template::class,'id','pid');
    }
}
