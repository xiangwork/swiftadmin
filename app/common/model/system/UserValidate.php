<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use app\common\library\Globals;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class UserValidate extends Model
{
    use SoftDelete;
    
    // 定义时间戳字段名
    protected $createTime = 'create_time';

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

}
