<?php
declare (strict_types=1);
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

use think\facade\Event;
use app\common\library\Ftp;
use app\common\library\Images as ImagesModel;
use app\common\model\system\Attachment;
use system\Http;

/**
 * UPLOAD文件上传类
 */
class Upload
{

    /**
     * @var object 对象实例
     */
    protected static $instance = null;

    /**
     * 文件类型
     */
    protected $fileclass;

    /**
     * 文件名称
     */
    protected $filename;

    /**
     * 文件保存路径
     */
    protected $filepath;

    /**
     * 文件全路径名称
     */
    protected $resource;

    /**
     * 图形对象实例
     */
    protected $Images;

    /**
     * 上传来源
     */
    protected $ckeditor;

    /**
     * 错误信息
     */
    protected $_error = '';

    /**
     * 配置文件
     */
    protected $config = [];

    /**
     * 类构造函数
     * class constructor.
     */
    public function __construct()
    {
        $this->Images = new ImagesModel();
        if ($config = saenv('upload', true)) {
            $this->config = array_merge($this->config, $config);
        }
    }

    /**
     * 初始化
     * @access public
     * @param array $options 参数
     * @return self
     */

    public static function instance($options = [])
    {
        if (is_null(self::$instance)) {
            self::$instance = new static($options);
        }
        // 返回实例
        return self::$instance;
    }

    /**
     * logo 上传
     */
    public function logo()
    {

        // 接收文件信息
        $file = request()->file('file');
        if (!$file || is_empty($file)) {
            $this->setError('上传文件读写失败！');
            return false;
        }

        // 文件信息过滤器
        if (!$this->fileFilter($file)) {
            $this->setError($this->_error ?? '禁止上传的文件类型！');
            return false;
        }

        $this->filename = 'logo.' . strtolower($file->extension());
        $this->filepath = 'static/images/';

        // 移动上传文件
        if (!$file->move($this->filepath, $this->filename)) {
            $this->setError('请检查服务器读写权限！');
            return false;
        }

        return $this->success('上传logo成功！', '/' . $this->filepath . $this->filename);
    }

    /**
     * 用户头像上传
     */
    public function avatar($id = 0)
    {
        return $this->realUpload(true, $id);
    }

    /**
     * 普通文件上传
     */
    public function upload()
    {
        return $this->realUpload();
    }

    /**
     * 上传函数实例
     */
    public function realUpload(bool $avatar = false, $id = 0)
    {
        // 接收参数
        $param = input();
        $param['form'] = input('form/s');
        if ($param['form'] == 'ckeditor') {
            $param['input'] = $this->ckeditor = 'upload';
        } else {
            $param['input'] = 'file';
        }

        try {
            // 接收文件信息
            $file = request()->file($param['input']);

            if (empty($file)) {
                $this->setError('上传文件读写失败！');
                return false;
            }

        } catch (\Throwable $th) {
            return $this->error($th->getMessage());
        }

        // 文件信息过滤器
        if (!$this->fileFilter($file)) {
            $this->setError($this->_error);
            return false;
        }

        // 拼接文件路径
        if ($avatar) {
            $this->filename = md5((string)$id) . '_100x100.' . strtolower($file->extension());
            $this->filepath = $this->config['upload_path'] . '/avatars';
        } else {
            $this->filename = uniqid() . '.' . strtolower($file->extension());
            $this->filepath = $this->config['upload_path'] . '/' . $this->fileclass . '/' . date($this->config['upload_style']);
        }

        $this->resource = $this->filepath . '/' . $this->filename;

        $attachment = [
            'filename' => $file->getOriginalName(), // 保存原始文件名
            'filesize' => $file->getSize(),
            'url' => '/' . $this->resource,
            'suffix' => $file->extension(),
            'mimetype' => $file->getMime(),
            'user_id' => cookie('uid') ?? 0,
            'sha1' => $file->hash(),
        ];


        // 移动上传文件
        if (!$file->move($this->filepath, $this->filename)) {
            $this->setError('请检查服务器读写权限！');
            return false;
        }

        // 上传阿里云/FTP空间
        if (!$this->uploadOss() || !$this->uploadFtp()) {
            return false;
        }

        // 过滤gif文件
        if ($this->fileclass == "images" && !strstr($file->extension(), 'gif')) {

            // 设置水印/微缩图
            if ($this->config['upload_water']) {
                $this->Images->waterMark($this->resource, $this->config);
            }

            if ($this->config['upload_thumb'] || $avatar) {
                $this->Images->thumb($this->filepath, $this->filename, $this->config, $avatar);
            }
        }

        Attachment::create($attachment);

        return $this->success('文件上传成功！', '/' . $this->resource);
    }

    protected function uploadOss()
    {
        if (saenv('cloud_status')) {

            if (!Event::hasListener('clouduploads')) {
                $this->setError('未安装云上传插件');
                return false;
            }

            try {
                // 开启云上传
                if (Event::trigger('clouduploads', [
                            'type' => saenv('cloud.type'),
                            'object' => $this->resource,
                            'filename' => $this->resource
                        ]
                    ) !== false) {
                    // 删除本地文件
                    if ($this->config['upload_del']) {
                        unlink($this->resource);
                    }
                }
            } catch (\Throwable $th) {
                $this->setError($th->getMessage());
                return false;
            }
        }

        return true;
    }

    protected function uploadFtp()
    {
        // 上传FTP空间
        if ($this->config['upload_ftp']) {

            // 存在微缩图则上传
            $thumbfile = $this->filepath . '/thumb_' . $this->filename;
            if ($this->config['upload_ftp'] && is_file($thumbfile)) {
                 Ftp::instance()->ftpUpload($thumbfile, $this->filepath, 'thumb_' . $this->filename, $this->config);
            }

            $ftpstatus = Ftp::instance()->ftpUpload($this->resource, $this->filepath, $this->filename, $this->config);
            if ($ftpstatus) {

                // 删除本地文件
                if ($this->config['upload_del']) {
                    unlink($thumbfile);
                    unlink($this->resource);
                }
            } else {

                $this->setError('文件上传至FTP服务器异常');
                return false;
            }
        }

        return true;
    }

    /**
     * 验证文件类型
     */
    public function fileFilter($file)
    {
        // 查找文件类型	
        foreach ($this->config['upload_class'] as $key => $value) {
            if (stripos($value, strtolower($file->extension()))) {
                $this->fileclass = $key;
                break;
            }
        }

        // 验证一句话木马 /*如果是加密的无法判断*/
        $tempFile = $file->getPathname();
        $content = @file_get_contents($tempFile);
        if (false == $content
            || preg_match('#<\?php#i', $content)
            || $file->getMime() == 'text/x-php') {
            $this->fileclass = null;
        }

        if ($this->fileclass == null) {
            $this->_error = '禁止上传的文件类型';
            return false;
        }

        // 文件验证器
        $validate = new \app\common\validate\system\UploadFile();
        if (!$validate->check([$this->fileclass => $file])) {
            $this->fileclass = null;
            $this->_error = $validate->getError();
        }

        // 未找到类型或验证文件失败
        return empty($this->fileclass) ? false : true;
    }

    /**
     * JSON格式化信息
     */
    public function success($msg, $url)
    {
        try {
            // 编辑器上传回显已去除
            if (!is_empty($this->ckeditor)
                && ($this->config['upload_ftp'] || saenv('cloud.status'))) {
                $url = str_replace('http:', '', $this->config['upload_http_prefix']) . $url;
            }
        } catch (\Throwable $th) {
            echo $th->getMessage();
        }

        // 非空自动增加HTTP前缀
        $prefix = cdn_Prefix();
        if (!empty($prefix)) {
            $url = $prefix . $url;
        }

        return ['code' => 200, 'msg' => $msg, 'url' => $url];
    }

    public function error($msg)
    {
        return ['code' => 101, 'msg' => $msg];
    }

    /**
     * 获取最后产生的错误
     * @return string
     */
    public function getError()
    {
        return $this->_error;
    }

    /**
     * 设置错误
     * @param string $error 信息信息
     */
    protected function setError($error)
    {
        $this->_error = $error;
    }

}