<?php
declare (strict_types = 1);

namespace app\common\model\system;

use app\common\library\Content as ContentLibrary;
use think\Model;

/**
 * @mixin \think\Model
 */
class ContentVideo extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    /**
     * 修改Banner横图
     * @access  public
     * @param   string      $image
     * @return  string
     */ 
    public function setBannerAttr($image,$data)
    {
        return ContentLibrary::setImageAttr($image,$data);
    }

    /**
     * 获取Banner横图
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public function getBannerAttr($image)
    {
        return ContentLibrary::getImageAttr($image);
    }

    /**
     * 修改播放器
     * @access  public
     * @param mixed $play
     * @param mixed $data
     * @return int
     */
    public function setPlayAttr($play,$data) 
    {
        $play = array_filter($play);
        foreach ($play as $key => $value) {
            if (empty($data['url'][$key])) {
                unset($play[$key]);
            }
        }

        return strval(implode('$$$',$play));
    }

    public function getPlayAttr($play) 
    {   
        if (!empty($play)) {
            $play = explode('$$$',$play);
        }

        return $play;
    }

    /**
     * 修改播放器
     * @access  public
     * @param mixed $play
     * @param mixed $data
     * @return int
     */
    public function setUrlAttr($Url, $data) 
    {
        $urls = [];
        foreach ($data['play'] as $key => $value) {
            $urls[$key] = $Url[$key];
        }
        $Url = array_filter($urls);
        $Url = strval(implode('$$$',str_replace(Chr(10),'#', $Url)));
        return $Url;
    }

    /**
     * 获取播放器名称
     * @access  public
     * @param mixed $Url
     * @return int
     */
    public function getUrlAttr($Url) 
    {   
        if (!empty($Url)) {
            $Url = explode('$$$',str_replace('#',Chr(10), $Url));	
        }
        return $Url;
    }

    /**
     * 修改服务器
     * @access  public
     * @param mixed $server
     * @param mixed $data
     * @return int
     */
    public function setServerAttr($server,$data)
    {   
        foreach ($data['play'] as $key => $value) {
            if (isset($server[$key])) {
                $servers[$key] = $server[$key];
            }
            else {
                $servers[$key] = '';
            }
        }
        $server = strval(implode('$$$',$servers));
        return $server;
    }

    /**
     * 获取服务器数据
     * @access  public
     * @param mixed $server
     * @return int
     */
    public function getServerAttr($server) 
    {   
        if (!empty($server)) {
            $server = explode('$$$',$server);
        }

        return $server;
    }

    /**
     * 查找备注信息
     * @access  public
     * @param mixed $note
     * @param mixed $data
     * @return int
     */
    public function setNoteAttr($note,$data)
    {   
        foreach ($data['play'] as $key => $value) {
            if (isset($note[$key])) {
                $notes[$key] = $note[$key];
            }
            else {
                $notes[$key] = '';
            }
        }

        $note = strval(implode('$$$',$notes));
        return $note;
    }

    /**
     * 获取备注信息
     * @access  public
     * @param mixed $note
     * @return int
     */
    public function getNoteAttr($note) 
    {   
        if (!empty($note)) {
            $note = explode('$$$',$note);
        }

        return $note;
    }

    /**
     * 格式化上映时间
     * @access  public
     * @param mixed $filmtime
     * @return int
     */
    public function setFilmtimeAttr($filmtime)
    {   
        if (!empty($filmtime) && is_string($filmtime)) {
            $filmtime = strtotime($filmtime);
        }
        if (is_numeric($filmtime) && $filmtime > 0) {
            return $filmtime;
        }
        return '';
    }

    /**
     * 转换时间格式
     * @access  public
     * @param mixed $filmtime
     * @return int
     */
    public function getFilmtimeAttr($filmtime)
    {   
        if (!empty($filmtime)) {
            $filmtime = date('Y-m-d H:i:s',$filmtime);
        }
        return $filmtime;
    }

}
