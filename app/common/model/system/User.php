<?php
declare (strict_types = 1);

namespace app\common\model\system;
use think\Model;
use system\Random;
use app\common\library\Globals;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class User extends Model
{
    use SoftDelete;
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    // 定义第三方关联
    public function third()
    {
        return $this->hasMany(UserThird::class,'user_id');
    }

    /**
     * 关联用户组
     *
     * @return void
     */
    public function group()
    {
        return $this->hasOne(UserGroup::class,'id','group_id');
    }

    /**
     * 关联评论列表
     *
     * @param integer $id
     * @return void
     */
    public function comment()
    {
        return $this->hasMany(Comment::class,'user_id');
    }

    /**
     * 注册会员前
     * @param  object  $data
     * @return object 
     */
    public static function onBeforeInsert($data)
    {}

    /**
     * 更新会员前
     * @param  object  $data
     * @return object 
     */
    public static function onBeforeUpdate($data)
    {}

    /**
     * 注册会员后
     * @param   object  $data
     * @return string
     */
    public static function onAfterInsert($data)
    {}

    /**
     * 更新会员数据
     * @param   object  $data
     * @return string
     */
    public static function onAfterUpdate($data)
    {}
    
    /**
     * 获取头像
     * @param   string $value
     * @param   array  $data
     * @return string
     */
    public function getAvatarAttr($value, $data)
    {
        
        if ($value && strpos($value,'://')) {
            return $value;
        }
        
        if (empty($value)) {
            $value = letter_avatar($data['nickname']);
        }

        $prefix = cdn_Prefix();
        if (!empty($prefix) && $value) {
            if (!strstr($value,'data:image')) { 
                return $prefix.$value;
            }
        }

        return $value;
    }

    /**
     * 设置头像
     * @param   string $value
     * @param   array  $data
     * @return string
     */
    public function setAvatarAttr($value, $data)
    {
        return Globals::setImageAttr($value,$data);
    }

    /**
     * 登录时间
     */
    public function getLogintimeAttr($value)
    {
        if (!empty($value)) {
            $value = date('Y-m-d H:i:s',$value);
        }

        return $value;
    }

    /**
     * 设置创建IP
     */
    public function setCreateipAttr($ip)
    {
        return Globals::setIPAttr($ip);
    }

    /**
     * 获取创建IP
     */
    public function getCreateipAttr($ip)
    {
        return Globals::getIPAttr($ip);
    }

    /**
     * 设置登录IP
     */
    public function setLoginipAttr($ip)
    {
        return Globals::setIPAttr($ip);
    }

    /**
     * 获取登录IP
     */
    public function getLoginipAttr($ip)
    {
        return Globals::getIPAttr($ip);
    }

    /**
     * 设置IP转换
     * @access  public
     * @param   string     $ip  IP地址
     * @return  string
     */
    public function setIPAttr($ip)
    {
        return Globals::setIPAttr($ip);
    }

    /**
     * 获取IP转换
     * @access  public
     * @param   int     $ip  整型
     * @return  string
     */
    public function getIPAttr($ip)
    {
        return Globals::getIPAttr($ip);
    }

    /**
     * 减少会员积分
     *
     * @param integer $id
     * @param integer $score
     * @return void
     */
    public static function reduceScore(int $id = 0, int $score = 0)
    {
        try {
            self::where('id',$id)->dec('score',$score)->update();
        } catch (\Throwable $th) {}
    }
}

