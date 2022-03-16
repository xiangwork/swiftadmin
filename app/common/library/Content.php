<?php

declare(strict_types=1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> Apache 2.0 License Code
// +----------------------------------------------------------------------
namespace app\common\library;

/**
 * 全局模型数据处理类
 * 1、自动设置字段属性
 * 2、执行数据库事件回调
 */
class Content
{

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
     * 自动获取描述
     * @access      public
     * @param       string       $description      属性值
     * @param       array        $data              当前数组
     * @return      string
     */
    public static function setSeodescriptionAttr($description, $data)
    {
        if (empty($description) && !empty($data['content'])) {
            return msubstr($data['content'], 0, 80);
        }

        return $description;
    }

    /**
     * 内容数据修改器
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public static function setContentAttr($content, $data)
    {
        if ($prefix = cdn_Prefix()) {
            $content = str_replace($prefix, '', $content);
        }

        return htmlspecialchars($content);
    }

    /**
     * 获取内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public static function getContentAttr($content, $data)
    {
        if (!empty($content)) {

            $content = htmlspecialchars_decode($content);

            // 是否开启前缀
            if ($prefix = cdn_Prefix()) {
                $pattern = "/<img.*?src=\"(.*?)\"/i";
                if (preg_match_all($pattern, $content, $images)) {
                    $images = array_unique($images[1]);
                    foreach ($images as $value) {
                        $value = urldecode($value);
                        if (!strpos($value, '://')) {
                            $content = str_replace($value, $prefix . $value, $content);
                        }
                    }
                }
            }
        }

        return $content;
    }

    /**
     * 自动补全图片
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public static function setImageAttr($image, $data, $ready = false)
    {
        if (empty($image) && !empty($data['content']) && $ready) {
            $pattern = "/<img.*?src=\"(.*?)\"/i";
            $prefix = cdn_Prefix();
            if (preg_match($pattern, $data['content'], $images)) {
                return $prefix ? str_replace($prefix, '', $images[1]) : $images[1];
            }
        }

        return self::changeImages($image, false);
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

        if ($image && strpos($image, '://')) {
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
        $prefix = cdn_Prefix();
        if (!empty($prefix) && $image) {

            // 过滤base64
            if (!strstr($image, 'data:image')) {
                return $bool ? $prefix . $image : str_replace($prefix, '', $image);
            }
        }

        return $image;
    }

    /**
     * 获取IP转换
     * @access  public
     * @param   int     $ip  整型
     * @return  string
     */
    public static function getIPAttr($ip)
    {
        if ($ip) {
            $ip = long2ip($ip);
        }
        return $ip;
    }

    /**
     * 设置IP转换
     * @access  public
     * @param   string     $ip  IP地址
     * @return  string
     */
    public static function setIPAttr($ip)
    {
        if ($ip) {
            $ip = ip2long($ip);
        }

        return $ip;
    }

    /**
     * 设置独立模板
     * @access  public
     * @param   string     $skin  模板名称
     * @return  string
     */
    public static function setSkinAttr($skin)
    {
        if ($skin) {
            $skin = str_replace(['.html', '.htm'], '', $skin);
        }

        return $skin;
    }

    /**
     * 获取内容页地址
     * @access  public
     * @param   mixed $readUrl
     * @param   object $data
     * @return  string
     */
    public static function getReadurlAttr($readUrl, $data)
    {
    }
}
