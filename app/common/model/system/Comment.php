<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\facade\Db;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class Comment extends Model
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    public function user()
    {
        return $this->hasOne(User::class,'id','uid')->fieldRaw("ifnull(name,'游客') as name,ifnull(avatar,'/static/images/user_def.jpg') as avatar");
    }
}
