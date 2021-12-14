<?php
declare (strict_types = 1);

namespace app\common\model\system;

use app\admin\controller\system\Rewrite;
use think\Model;
use think\model\concern\SoftDelete;
use app\common\library\Content as ContentLibrary;
use app\common\model\system\Channel as ChannelModel;

/**
 * @mixin \think\Model
 */
class Content extends Model
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;
    
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
     * 默认关联模型
     * @access  public
     * @return  void
     */
    public function article()
    {
        return $this->hasOne(ContentArticle::class,'content_id','id');
    }

    /**
     * 关联图片模型
     *
     * @return void
     */
    public function images()
    {
        return $this->hasOne(ContentImages::class,'content_id','id');
    }

    /**
     * 关联软件模型
     *
     * @return void
     */

    public function soft()
    {
        return $this->hasOne(ContentSoft::class,'content_id','id');
    }

    /**
     * 关联产品模型
     *
     * @return void
     */
    public function product()
    {
        return $this->hasOne(ContentProduct::class,'content_id','id');
    }

    /**
     * 关联视频模型
     *
     * @return void
     */
    public function video()
    {
        return $this->hasOne(ContentVideo::class,'content_id','id');
    }

    /**
     * 关联标签
     * @return void
     */
    public function tags()
    {
        return $this->belongsToMany(Tags::class,TagsMapping::class,'tid','cid');
    }

    /**
     * 数据写入前
     * @access  public
     * @param   object
     * @return  void
     */
    public static function onBeforeWrite($data)
    {
        return ContentLibrary::onBeforeWrite($data);
    }

    /**
     * 数据新增前
     * @access  public
     * @param   object 
     * @return  void
     */
    public static function onBeforeInsert($data)
    {
        return ContentLibrary::onBeforeInsert($data);
    }

    /**
     * 数据新增后
     * @param   object  
     * @return  string
     */
    public static function onAfterInsert($data)
    {
        return ContentLibrary::onAfterInsert($data->toArray(), 'content');
    }

    /**
     * 数据更新前
     * @param   object 
     * @return  string
     */
    public static function onBeforeUpdate($data)
    {
        return ContentLibrary::onBeforeUpdate($data);
    }    

    /**
     * 数据更新后
     * @param   object 
     * @return  string
     */
    public static function onAfterUpdate($data)
    {
        return ContentLibrary::onAfterUpdate($data->toArray(), 'content');
    }

    /**
     * 数据写入后
     * @param   object
     * @return  string
     */
    public static function onAfterWrite($data)
    {
        // 默认开启静态生成
        if (saenv('url_model') == STATICS) {
            $buildHtml = new Rewrite(app('app'));
            $buildHtml->createhtmlByone($data);
        }
    }

    /**
     * 数据删除前
     * @access      public
     * @param       array 
     * @return      string
     */
    public static function onBeforeDelete($data)
    {
        return ContentLibrary::onBeforeDelete($data);
    }

    /**
     * 数据删除后
     * @access      public
     * @param       array   
     * @return      string
     */    
    public static function onAfterDelete($data)
    {
        return ContentLibrary::onAfterDelete($data, 'content');
    }

    /**
     * 数据恢复前
     * @access      public
     * @param       array 
     * @return      string
     */
    public static function onBeforeRestore($data)
    {
        return ContentLibrary::onBeforeRestore($data);
    }

    /**
     * 数据恢复后
     * @access      public
     * @param       array 
     * @return      string
     */
    public static function onAfterRestore($data)
    {
        return ContentLibrary::onAfterRestore(self::_extendFields($data), 'content');
    }

    /**
     * 内容扩展字段集
     *
     * @param object $data
     * @return object
     */
    public static function _extendFields(object $data)
    {
        $channel = ChannelModel::getChannelList($data['cid']);
        $property = $data->$channel['table']->toArray();
        $result = $data->toArray();
        foreach ($property as $key => $value) {
            if (!isset($result[$key])) {
                $result[$key] = $value;
            }
        }

        return $result ?? [];
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
        return ContentLibrary::setLetterAttr($letter,$data);
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
        return ContentLibrary::setAttributeAttr($attribute,$data);
    }

    /**
     * 修改图片
     * @access  public
     * @param   string  $image
     * @return  string
     */
    public function setImageAttr($image,$data)
    {
        return ContentLibrary::setImageAttr($image,$data,true);
    }

    /**
     * 获取图片
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function getImageAttr($image)
    {
        return ContentLibrary::getImageAttr($image);
    }

    /**
     * 修改缩略图
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public function setThumbAttr($image,$data)
    {
        return ContentLibrary::setImageAttr($image,$data);
    }

    /**
     * 获取缩略图
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public function getThumbAttr($image)
    {
        return ContentLibrary::getImageAttr($image);
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
        if (!empty($readUrl)) {
            return $readUrl;
        }

        if (isset($data['attr']['jumpurl'])
            && !empty($data['attr']['jumpurl'])) {
            return $data['attr']['jumpurl'];
        }

        // 获取列表样式
        $urlStyle = saenv('content_style');
        if (strstr($urlStyle,'[model]')) {
            $module = Channel::getChannelList($data['cid'],null,'module');
            $readUrl = '/'.$module.'/'.$data['id'].'.html';
        } else {

            $current = list_search(Category::getListCache(),['id' => $data['pid']]);
            if (strstr($urlStyle,'[sublist]') && $current['pid']) {
                $parent = list_search(Category::getListCache(),['id' => $current['pid']]);
            }
      
            // 确定父类存在
            if (!isset($parent) || empty($parent['pinyin'])) {
                $readUrl = '/'.$current['pinyin'].'/'.$data['id'].'.html';
            }
            else {
                $readUrl = '/'.$parent['pinyin'].'/'.$current['pinyin'].'/'.$data['id'].'.html';
            }
        }
        
        return saenv('url_domain') ? saenv('site_http') . $readUrl : $readUrl;
    }

    /**
     * 设置独立模板
     * @access  public
     * @param   int  $skin
     * @return  int 
     */
    public function setSkinAttr($skin) 
    {
        return ContentLibrary::setSkinAttr($skin);
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

}
