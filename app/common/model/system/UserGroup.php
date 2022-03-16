<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\facade\Db;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class UserGroup extends Model
{
    use SoftDelete;
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    

    /**
     * 获取用户组
     *
     * @param integer $id
     * @param boolean $mark
     * @return void|array
     */
    public static function ToObtain(int $id = 0, bool $mark = true)
    {
        $groupList = system_cache('groupList');

        // 优先读取缓存
        if (empty($groupList)) {
            $groupList = self::select()->toArray();
            system_cache('groupList',$groupList,86400);
        }

        return $groupList;
    }
}

