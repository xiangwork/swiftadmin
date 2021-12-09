<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\facade\Event;
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
     * 验证邀请码
     *
     * @param string $code
     * @param boolean $marks
     * @return void
     */
    public static function check($code = '', bool $marks = false) 
    {

        $result = self::findCode($code);
        if (!empty($result)) {

            // 注册回调
            Event::listen("InvitecodeOk",function($params) {
                $result = self::findCode($params['code']);
                $result->ruid = $params['id'];
                $result->status = 0;
                $result->save();
            });

            return true;
        }

        return false;
    }

    /**
     * 删除邀请码
     *
     * @param string $code
     * @return void
     */
    public static function del(string $code = '') 
    {
        $Invitecode = UserInvitecode::where("code",$code)->find();
        $Invitecode->delete();
    }

    /**
     * 查询邀请码
     *
     * @param string $code
     * @return void|object
     */
    public static function findCode(string $code = '')
    {
        $Invitecode = self::where([
            ['code','=',$code],
            ['status','=',1],
        ])->find();

        return $Invitecode;
    }

}
