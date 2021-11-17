<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;

/**
 * @mixin \think\Model
 */
class ContentImages extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
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
            $prefix = get_upload_Http_Perfix();
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
            $prefix = get_upload_Http_Perfix();
            if (!empty($prefix) && is_array($album)) {
                foreach ($album as $key => $value) {
                    $album[$key]['src'] = $prefix.$value['src'];
                }
            }
        }

        return $album;
    }
}
