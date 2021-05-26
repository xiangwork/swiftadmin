<?php
declare (strict_types = 1);

namespace app\common\model\system;

use app\common\library\Content;
use think\Model;
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

    /**
     * 获取当前对象
     * @access  public
     * @return  void
     */
    public function video()
    {
        return $this->hasOne(Video::class,'id','sid');
    }    

    public function user()
    {
        return $this->hasOne(User::class,'id','uid')->fieldRaw("ifnull(name,'游客') as name,ifnull(avatar,'/static/images/user_default.jpg') as avatar");
    }

    /**
     * 设置IP转换
     * @access  public
     * @param   string     $ip  IP地址
     * @return  string
     */
    public function setIPAttr($ip)
    {
        return Content::setIPAttr($ip);
    }

    /**
     * 获取IP转换
     * @access  public
     * @param   int     $ip  整型
     * @return  string
     */
    public function getIPAttr($ip)
    {
        return Content::getIPAttr($ip);
    }    
}
