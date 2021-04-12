<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class UserInvitecode extends Model
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    /**
     * 验证激活码
     */
    public static function check($code = '', bool $marks = false) 
    {
        if ($result = self::where('code',$code)->find()) {
            
            if ($marks) {
                $result->delete();
            }

            return true;
        }
        return false;
    }

    /**
     * 删除激活码
     */
    public static function del(string $code = '') 
    {
        $Invitecode = UserInvitecode::where("code",$code)->find();
        $Invitecode->delete();
    }

}
