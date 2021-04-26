<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class User extends Model
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    // 定义第三方关联
    public function third()
    {
        return $this->hasMany(UserThird::class,'user_id');
    }

    /**
     * 获取头像
     * @param   string $value
     * @param   array  $data
     * @return string
     */
    public function getAvatarAttr($value, $data)
    {
        if (!$value) {
            $value = letter_avatar($data['name']);
        }
        return $value;
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
     * 登录IP
     */
    public function getLoginipAttr($value)
    {
        if (!empty($value)) {
            $value = long2ip($value);
        }

        return $value;
    }

    /**
     * 设置密码
     */
    public function setPwdAttr($value)
    {
        if (!empty($value)) {
            $value = hash_pwd($value);
        }

        return $value;
    }

}

