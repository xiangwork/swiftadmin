<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use app\common\library\Content as ContentLibrary;

/**
 * @mixin \think\Model
 */
class ContentArticle extends Model
{
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    /**
     * 修改内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function setContentAttr($content,$data)
    {
        return ContentLibrary::setContentAttr($content,$data);
    }

    /**
     * 获取内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function getContentAttr($content,$data)
    {
        return ContentLibrary::getContentAttr($content,$data);
    }

}
