<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use app\common\library\Content as ContentLibrary;

/**
 * @mixin \think\Model
 */
class ContentImages extends Model
{
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    /**
     * 序列化图册数据
     * @access  public
     * @param   mixed $album
     * @return  string
     */
    public function setalbumAttr($album)
    {
        if ($album) {
            $prefix = cdn_Prefix();
            if (!empty($prefix) && is_array($album)) {
                foreach ($album as $key => $value) {
                    $album[$key] = str_replace($prefix,'',$value);
                }
            }
            return serialize($album);
        }
        return $album;
    }

    /**
     * 获取图册序列数据
     * @access  public
     * @param   mixed $album
     * @return  string
     */
    public function getalbumAttr($album)
    {
        if ($album) {
            $album = unserialize($album);
            $prefix = cdn_Prefix();
            if (!empty($prefix) && is_array($album)) {
                foreach ($album as $key => $value) {
                    $album[$key]['src'] = $prefix.$value['src'];
                }
            }
        }

        return $album;
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
