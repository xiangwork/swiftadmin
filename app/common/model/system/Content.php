<?php

declare(strict_types=1);

namespace app\common\model\system;

use app\common\model\system\Channel;
use app\admin\controller\system\Rewrite;
use think\Model;
use think\model\concern\SoftDelete;
use app\common\library\Content as ContentLibrary;
use think\facade\Db;
use WordAnalysis\Analysis;

/**
 * @mixin \think\Model
 */
class Content extends Model
{
    use SoftDelete;

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
        return $this->hasOne(Category::class, 'id', 'pid');
    }

    /**
     * 获取当前模型
     * @access  public
     * @return  void
     */
    public function channel()
    {
        return $this->hasOne(Channel::class, 'id', 'cid');
    }

    /**
     * 默认关联模型
     * @access  public
     * @return  void
     */
    public function article()
    {
        return $this->hasOne(ContentArticle::class, 'id', 'id');
    }

    /**
     * 关联图片模型
     *
     * @return void
     */
    public function images()
    {
        return $this->hasOne(ContentImages::class, 'id', 'id');
    }

    /**
     * 关联软件模型
     *
     * @return void
     */

    public function soft()
    {
        return $this->hasOne(ContentSoft::class, 'id', 'id');
    }

    /**
     * 关联产品模型
     *
     * @return void
     */
    public function product()
    {
        return $this->hasOne(ContentProduct::class, 'id', 'id');
    }

    /**
     * 关联视频模型
     *
     * @return void
     */
    public function video()
    {
        return $this->hasOne(ContentVideo::class, 'id', 'id');
    }

    /**
     * 关联标签
     * @return void
     */
    public function tags()
    {
        return $this->belongsToMany(Tags::class, TagsMapping::class, 'tag_id', 'aid');
    }

    /**
     * 数据新增前
     * @access  public
     * @param   object 
     * @return  void
     */
    public static function onBeforeInsert($data)
    {
        if (!isset($data['admin_id']) || !$data['admin_id']) {
            $data['admin_id'] = session('AdminLogin.id') ?? 0;
        }

        if (!isset($data['user_id']) || !$data['user_id']) {
            $data['user_id'] = cookie('uid') ?? 0;
        }
    }

    /**
     * 数据新增后
     * @param   object  
     * @return  string
     */
    public static function onAfterInsert($data)
    {
        $parent = Category::find($data['pid']);
        if (!empty($parent)) {
            $parent->items++;
            $parent->save();
        }
    }

    /**
     * 数据写入后
     * @param   object
     * @return  string
     */
    public static function onAfterWrite($data)
    {

        // 关键词
        if (isset($data['keywords']) && $data['keywords']) {
            TagsMapping::writeRelation((int)$data['id'], $data['keywords']);
        }

        if (isset($data['cid']) && $data['cid']) {

            $parents = Channel::find($data->cid);

            if ($parents && !empty($data['content'])) {

                $content = htmlspecialchars_decode($data['content']);

                // 清理超链接
                if (saenv('site_clearLink')) {
                    $pattern = "/<a[^>]*>(.*?)<\/a>/is";
                    $content = preg_replace($pattern, "$1", $content);
                }

                // 获取相关词
                $keyArr = Analysis::getKeywords(msubstr($content));
                $keyArr = explode(',', $keyArr);
                $keywords = explode(',', $data->keywords);
                $keywords = array_unique(array_merge($keywords, $keyArr));
                if (!empty($keywords)) {

                    $keyList = Tags::where('name', 'in', $keywords)->select();
                    foreach ($keyList as $value) {
                        $link = <<<Eof
                        <a href="/tags/{$value['pinyin']}.html" target="_blank">{$value['name']}</a>
                        Eof;
                        $content = str_replace($value['name'], $link, $content);
                    }
                }

                // 查询附表字段
                $table = $parents['table'];
                $fields = $data->$table()->getFields();
                $values = array_intersect_key($data->toArray(), $fields);

                // 写入关联表数据
                $values['id'] = (int)$data->id;
                $values['createime'] = time();
                $data->$table()->save($values);
            }
        }

        // 更新索引
        if (saenv('search_status')) {
            search_model()::instance()->index('content')->save($data->toArray());
        }

        
        

    }

    /**
     * 数据删除后
     * @access      public
     * @param       array   
     * @return      string
     */
    public static function onAfterDelete($data)
    {
        if (isset($data['delete_force'])) {
            
            if (saenv('search_status')) {
                search_model()::instance()->index('content')->delete($data['id']);
            }

            // 清理关键词
            TagsMapping::where('aid',$data['id'])->delete();

        } else {

            if (saenv('search_status')) {
                search_model()::instance()->index('content')->save([
                    'id' => $data->id,
                    'status' => 0
                ], true);
            }
        }
    }

    /**
     * 数据恢复后
     * @access      public
     * @param       array 
     * @return      string
     */
    public static function onAfterRestore($data)
    {
        if (saenv('search_status')) {
            search_model()::instance()->index('content')->save([
                'id' => $data->id,
                'status' => 1
            ], true);
        }
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
        return ContentLibrary::setLetterAttr($letter, $data);
    }

    /**
     * 修改图片
     * @access  public
     * @param   string  $image
     * @return  string
     */
    public function setImageAttr($image, $data)
    {
        return ContentLibrary::setImageAttr($image, $data, true);
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
    public function setThumbAttr($image, $data)
    {
        return ContentLibrary::setImageAttr($image, $data);
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
     * 获取内容属性
     * @access      public
     * @param       string|array $attribute      属性值
     * @param       array        $data           当前数组
     * @return      string
     */
    public static function setAttributeAttr($attribute, $data) 
    {
        $pattern = "/<img.*?src=\"(.*?)\"/i";
        if (preg_match($pattern,$data['content'],$match)) {
            $attribute = array_merge($attribute,[5]);
        } else {
            $attribute = array_diff($attribute,[5]);
        }

        if (!empty($data['jumpurl'])) {
            $attribute = array_merge($attribute,[6]);
        } else {
            $attribute = array_diff($attribute,[6]);
        }
        
        // 删除重复数据
        $attribute = array_unique($attribute);
        if (is_array($attribute)) {
            $attribute = implode(',',$attribute);
        }

        return $attribute;
    }

    /**
     * 获取内容页地址
     * @access  public
     * @param   mixed $readUrl
     * @param   object $data
     * @return  string
     */
    public function getReadurlAttr($readUrl, $data)
    {
        if (!empty($readUrl)) {
            return $readUrl;
        }

        if (!empty($data['jumpurl'])) {
            return $data['jumpurl'];
        }

        // 获取列表样式
        $urlStyle = saenv('content_style');
        if (strstr($urlStyle, '[model]')) {
            $module = Channel::getChannelList($data['cid'], null, 'module');
            $readUrl = '/' . $module . '/' . $data['id'] . '.html';
        } else {

            $current = list_search(Category::getListCache(), ['id' => $data['pid']]);
            if (strstr($urlStyle, '[sublist]') && $current['pid']) {
                $parent = list_search(Category::getListCache(), ['id' => $current['pid']]);
            }

            // 确定父类存在
            if (!isset($parent) || empty($parent['pinyin'])) {
                $readUrl = '/' . $current['pinyin'] . '/' . $data['id'] . '.html';
            } else {
                $readUrl = '/' . $parent['pinyin'] . '/' . $current['pinyin'] . '/' . $data['id'] . '.html';
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
            return self::count('id') + 1;
        }
        return $sort;
    }
}
