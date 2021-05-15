<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> MIT License Code
// +----------------------------------------------------------------------
namespace app\common\library;

use WordAnalysis\Analysis;
use app\common\model\system\Recyclebin;

/**
 * 全局模型数据处理类
 * 1、自动设置字段属性
 * 2、执行数据库事件回调
 */
class Content 
{
    /**
     * 数据写入前置操作
     * @access  public
     * @param   object $data
     * @return  void
     */
    public static function onBeforeWrite($data)
    {}

    /**
     * 数据删除事件
     * @access      public
     * @param       array        $data           当前数组
     * @return      string
     */
    public static function onAfterDelete($data)
    {
        return Recyclebin::recycleData($data);
    }

    /**
     * 数据写入后
     * @param   object  $data
     * @return  string
     */
    public static function onAfterWrite($data)
    {
        try {
            if (saenv('url_model') == STATICS) {
                $base = new \app\admin\controller\system\Rewrite(app('app'));
                $base->createhtmlByone($data);
            }
        } catch (\Throwable $th) {
            throw new \Exception($th->getMessage());
        }
    }

    /**
     * 获取标题拼音
     * @access      public
     * @param       string       $pinyin         属性值
     * @param       array        $data           当前数组
     * @return      string
     */
    public static function setPinyinAttr($pinyin, $data) 
    {
        if (empty($pinyin)) {
            return pinyin($data['title'], true);
        }
        return $pinyin;
    }

    /**
     * 获取标题首字母
     * @access      public
     * @param       string       $letter         属性值
     * @param       array        $data           当前数组
     * @return      string
     */
    public static function setLetterAttr($letter, $data) 
    {
        if (empty($letter)) {
            return pinyin($data['title'], true, true);
        }
        return $letter;
    }  

    /**
     * 获取哈希值
     * @access      public
     * @param       string       $hash           属性值
     * @param       array        $data           当前数组
     * @return      string
     */
    public static function setHashAttr($hash, $data) 
    {
        if (empty($data['hash'])) {
            return md5hash($data['cid'].$data['id']);
        }

        return $hash;
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
     * 自动获取关键词
     * @access      public
     * @param       string       $keywords      属性值
     * @param       array        $data           当前数组
     * @return      string
     */
    public static function setSeokeywordsAttr($keywords, $data)
    {
        if (empty($keywords) && !empty($data['content'])) {
            $keywords = msubstr($data['content']);
            return Analysis::getKeywords($keywords);
        }

        return $keywords;
    }

    /**
     * 自动获取描述
     * @access      public
     * @param       string       $description      属性值
     * @param       array        $data              当前数组
     * @return      string
     */
    public static function setSeodescriptionAttr($description, $data)
    {
        if (empty($description) && !empty($data['content'])) {
            return msubstr($data['content'],0,76);
        }

        return $description;
    }

    /**
     * 内容数据修改器
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public static function setContentAttr($content,$data)
    {
        // 优先删除远程地址
        $prefix = get_upload_Http_Perfix();
        if (!empty($prefix)) {
            $content = str_replace($prefix,'',$content);
        }

        // 图片自动本地化
        $pattern = "/<img.*?src=\"(.*?)\"/i";
        $autolocal = saenv('upload_http_auto');
        if ($autolocal && preg_match_all($pattern, $content, $images)) {
            $images = array_unique($images[1]);
            $array  = Upload::instance()->download($images);
            foreach ($array as $key => $value) {
                $content = str_replace($key, $value, $content);
            }
        }

        // 清除非本站链接
        if (saenv('site_notlink')) {
            $match_all = [[]];
            $domain = request()->rootDomain();
            $pattern = "/<a.*href=\"(.*)\"[^>]*>(.*)<\/a>/iU";
            preg_match_all($pattern, $content, $match_all);

            // 后期添加锚文本扩展
            foreach ($match_all[1] as $key => $value) {
                if (strpos($value,'://') && !strpos($value,$domain)) {
                    $content = str_replace($value,'/',$content);
                }
            }
        }
        
        return htmlspecialchars($content);
    }

    /**
     * 获取内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public static function getContentAttr($content,$data)
    {
        if (!empty($content)) {

            // 解码
            $content = htmlspecialchars_decode($content);

            // 是否开启前缀
            $prefix = get_upload_Http_Perfix();
            if (!empty($prefix)) {
                $pattern = "/<img.*?src=\"(.*?)\"/i";
                if (preg_match_all($pattern, $content, $images)) {
                    $images = array_unique($images[1]);
                    foreach ($images as $value) {
                        $value = urldecode($value);
                        if (!strpos($value,'://')) {
                            $content = str_replace($value, $prefix.$value, $content);
                        }
                    }
                }
            }
        }

        return $content;
    }

    /**
     * 修改图片链接
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public static function setImageAttr($image,$data,$ready = false)
    {
        if (empty($image) && !empty($data['content']) && $ready) {
            $pattern = "/<img.*?src=\"(.*?)\"/i";
            $prefix = get_upload_Http_Perfix();
            if (preg_match($pattern, $data['content'], $images)) {
                return $prefix?str_replace($prefix,'',$images[1]):$images[1];
            }
        }

        return self::changeImages($image,false);
    }

    /**
     * 获取图片链接
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public static function getImageAttr($image)
    {
        if (!empty($image)) {
            $image = urldecode($image);
        }
        
        if ($image && strpos($image,'://')) {
            return $image;
        }

        return self::changeImages($image);
    }

    /**
     * 处理图片实例
     * @access  public
     * @param   string  $image  图片地址
     * @param   bool    $bool   链接OR替换
     * @return  string
     */
    protected static function changeImages($image, $bool = true)
    {
        $prefix = get_upload_Http_Perfix();
        if (!empty($prefix) && $image) {
            // 过滤BASE64图片数据
            if (!strstr($image,'data:image')) { 
                return $bool?$prefix.$image:str_replace($prefix,'',$image);
            }
        }

        return $image;
    }

    /**
     * 获取内容页地址
     * @access  public
     * @param   mixed $readUrl
     * @param   object $data
     * @return  string
     */
    public static function getReadurlAttr($readUrl,$data)
    {
        
        if ($data['jumpurl']) {
            return $data['jumpurl'];
        }
        
        if (!empty($readUrl)) {
            return $readUrl;
        }

        return build_request_url($data,'content_page');
    }
}
