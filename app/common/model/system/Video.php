<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;
use app\common\library\Content;

/**
 * @mixin \think\Model
 */
class Video extends Model
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    /**
     * 获取当前栏目
     * @access  public
     * @return  void
     */
    public function category()
    {
        return $this->hasOne(Category::class,'id','pid');
    }

    /**
     * 获取当前模型
     * @access  public
     * @return  void
     */
    public function channel()
    {
        return $this->hasOne(Channel::class,'id','cid');
    }

    /**
     * 数据写入前操作
     * @access  public
     * @param   object $data
     * @return  void
     */
    public static function onBeforeWrite($data)
    {
        return Content::onBeforeWrite($data);
    }

    /**
     * 数据写入后
     * @param   object  $data
     * @return  string
     */
    public static function onAfterWrite($data)
    {
        return Content::onAfterWrite($data);
    }

    /**
     * 数据删除事件
     * @access      public
     * @param       array        $data           当前数组
     * @return      string
     */    
    public static function onAfterDelete($data)
    {
        return Content::onAfterDelete($data);
    }
    
    /**
     * 获取标题拼音
     * @access      public
     * @param       string       $pinyin      属性值
     * @param       array        $data        当前数组
     * @return      string
     */
    public function setPinyinAttr($pinyin, $data) 
    {
        return Content::setPinyinAttr($pinyin,$data);
    }    
    
    /**
     * 获取标题首字母
     * @access      public
     * @param       string       $letter        属性值
     * @param       array        $data          当前数组
     * @return      string
     */
    public function setLetterAttr($letter, $data) 
    {
        return Content::setLetterAttr($letter,$data);
    }   

    /**
     * 获取哈希值
     * @access      public
     * @param       string       $hash          属性值
     * @param       array        $data          当前数组
     * @return      string
     */
    public function setHashAttr($hash, $data) 
    {
        $data['id'] = self::count();
        return Content::setHashAttr($hash,$data);
    }

    /**
     * 自动获取属性
     * @access      public
     * @param       string|array $attribute      属性值
     * @param       array        $data           当前数组
     * @return      string
     */
    public function setAttributeAttr($attribute, $data) 
    {
        return Content::setAttributeAttr($attribute,$data);
    }
    
    /**
     * 自动获取关键词
     * @access      public
     * @param       string       $keywords      属性值
     * @param       array        $data          当前数组
     * @return      string
     */
    public function setSeokeywordsAttr($keywords, $data)
    {
        return Content::setSeokeywordsAttr($keywords,$data);
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
        return Content::setSeodescriptionAttr($description,$data);
    }

    /**
     * 修改图片
     * @access  public
     * @param   string  $image
     * @return  string
     */
    public function setImageAttr($image,$data)
    {
        return Content::setImageAttr($image,$data,true);
    }

    /**
     * 获取图片
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function getImageAttr($image)
    {
        return Content::getImageAttr($image);
    }

    /**
     * 修改缩略图
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public function setThumbAttr($image,$data)
    {
        return Content::setImageAttr($image,$data);
    }

    /**
     * 获取缩略图
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public function getThumbAttr($image)
    {
        return Content::getImageAttr($image);
    }

    /**
     * 修改Banner横图
     * @access  public
     * @param   string      $image
     * @return  string
     */ 
    public function setBannerAttr($image,$data)
    {
        return Content::setImageAttr($image,$data);
    }
    
    /**
     * 获取Banner横图
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public function getBannerAttr($image)
    {
        return Content::getImageAttr($image);
    }

    /**
     * 修改内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function setContentAttr($content,$data)
    {
        return Content::setContentAttr($content,$data);
    }

    /**
     * 获取内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function getContentAttr($content,$data)
    {
        return Content::getContentAttr($content,$data);
    }

    /**
     * 获取内容页地址
     * @access  public
     * @param   mixed $readUrl
     * @param   object $data
     * @return  string
     */
    public function getReadurlAttr($readUrl,$data)
    {
        return Content::getReadurlAttr($readUrl,$data);
    }

    /**
     * 字段排序
     * @access  public
     * @param   int  $sort
     * @return  int 
     */
    public function setSortAttr($sort) 
    {
        if (is_empty($sort)) {
            return self::count('id')+1;
        }
        return $sort;
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

    /**
     * 设置独立模板
     * @access  public
     * @param   int  $skin
     * @return  int 
     */
    public function setSkinAttr($skin) 
    {
        return Content::setSkinAttr($skin);
    }    

}

