<?php
declare (strict_types = 1);

namespace app\common\model\system;

use app\common\library\Content as ContentLibrary;
use think\Model;

/**
 * @mixin \think\Model
 */
class ContentAttr extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    /**
     * 自动获取关键词
     * @access      public
     * @param       string       $keywords      属性值
     * @param       array        $data          当前数组
     * @return      string
     */
    public function setSeokeywordsAttr($keywords, $data)
    {
        return ContentLibrary::setSeokeywordsAttr($keywords,$data);
    }

    /**
     * 自动获取描述
     * @access      public
     * @param       string       $description      属性值
     * @param       array        $data             当前数组
     * @return      string
     */
    public function setSeodescriptionAttr($description, $data)
    {
        return ContentLibrary::setSeodescriptionAttr($description,$data);
    }


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
