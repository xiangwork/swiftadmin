<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;
use app\common\library\Globals;

/**
 * @mixin \think\Model
 */
class Comment extends Model
{
    use SoftDelete;
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    // 自定义关联字段
    protected $userField  = 'id,nickname,heart,loginip,avatar,readurl,score';

    /**
     * 关联用户
     *
     * @return void
     */
    public function user()
    {
        return $this->hasOne(User::class,'id','user_id')->field($this->userField);
    }

    /**
     * 获取回复ID
     *
     * @return void
     */
    public function replay()
    {
        return $this->hasOne(User::class,'id','rid')->field($this->userField);
    }

    /**
     * 关联回复
     * 限定5条数据/可用AJAX调用查询
     * @return void
     */
    public function child()
    {
        return $this->hasMany(self::class,'pid','id')->order('id asc')->limit(10)->with(['user','replay']);
    }
 
    /**
     * 修改内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function setContentAttr($content)
    {
        return htmlspecialchars($content);
    }

    /**
     * 获取内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function getContentAttr($content)
    {
        return html_entity_decode($content);
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
}
