<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class Adwords extends Model
{
    use SoftDelete;
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    public function getExpirestimeAttr($expirestime)
    {
        return date('Y-m-d H:i:s',$expirestime);
    }
}
