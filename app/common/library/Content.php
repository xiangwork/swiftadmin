<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2019-2020 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>，河北赢图网络科技版权所有
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
    {
        // 自动获取猥琐图
        if (!$data->thumb || !$data->image) {
            $pattern = "/<img.*?src=\"(.*?)\"/i";
            if (preg_match($pattern,$data->content,$match)) {

                if (!strpos($match[1],'://')) {
                    $fileinfo = pathinfo($match[1]);
                    $thumb    = 'thumb_'.$fileinfo['filename'];
                    $filepath = str_replace($fileinfo['filename'],$thumb,$match[1]);
                    if (is_file(public_path().$filepath)) {
                       $thumbimg = $filepath;
                    }
                }

                // 存在图片则跳过
                $data->image = !empty($data->image) ? $data->image : $match[1];
                $data->thumb = !empty($data->thumb) ? $data->thumb : $thumbimg ?? $match[1];
            }
        }
    }

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
            return md5short($data['cid'].$data['id']);
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
        
        // 清理重复数据
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
        // 自动本地化
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

            // 后期添加相应的扩展
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
            $content = htmlspecialchars_decode($content);
        }
        return $content;
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
        if (!empty($readUrl)) {
            return $readUrl;
        }

        return (string)url('/article/read/',['id'=>$data['id']])->domain(true)->suffix(true);
    }

    
}
