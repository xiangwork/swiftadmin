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

use think\facade\Event;
use app\common\library\Ftp;
use app\common\library\Images as ImagesModel;

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
        if ($config = saenv('upload')) {
            $this->config = array_merge($this->config, $config);
        }
    }

    /**
     * 初始化
     * @access public
     * @param  array $options 参数
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
        if (!$this->filefilter($file)) {
            $this->setError($this->_error ?? '禁止上传的文件类型！');
			return false;
        }

        $this->filename = 'logo.'.strtolower($file->extension());
        $this->filepath = 'static/images/';  

        // 移动上传文件
        if (!$file->move($this->filepath,$this->filename)) {
            $this->setError('请检查服务器读写权限！');
			return false;
        }

        return $this->success('上传logo成功！','/'.$this->filepath.$this->filename);
    }

    /**
     * 用户头像上传
     */
    public function avatar($id = 0) {
        return $this->realUpload(true,$id);
    }

    /**
     * 普通文件上传
     */
    public function upload() {
        return $this->realUpload();
    }

    /**
     * 真实上传函数
     */
    public function realUpload(bool $avatar = false, $id = 0)
    {
        // 接收参数
        $param = input(); 
		$param['form'] = input('form/s');
		if ($param['form'] == 'ckeditor') {
            $param['input'] = $this->ckeditor = 'upload';
		}else {
			$param['input'] = 'file';
        }

        try {
            // 接收文件信息
            $file = request()->file($param['input']);
            if (!$file || empty($file)) {
                $this->setError('上传文件读写失败！');
                return false;
            }

        } catch (\Throwable $th) {
            return  $this->error($th->getMessage());
        }

        // 文件信息过滤器
        if (!$this->filefilter($file)) {
            $this->setError($this->_error);
			return false;
        }

        // 拼接文件路径
        if ($avatar) {
            $this->filename = md5short((string)$id).'_100x100.'.strtolower($file->extension());
            $this->filepath = $this->config['upload_path'].'/avatar'; 
        }else {
            $this->filename = uniqid().'.'.strtolower($file->extension());
            $this->filepath = $this->config['upload_path'].'/'.$this->fileclass.'/'.date($this->config['upload_style']); 
        }
        
        $this->resource = $this->filepath .'/'. $this->filename;

        // 移动上传文件
        if (!$file->move($this->filepath, $this->filename)) {
            $this->setError('请检查服务器读写权限！');
			return false;
        }
        
        // 上传阿里云/FTP空间
        if (!$this->uploadOss() || !$this->uploadFtp()) {
            return false;
        }

        // 图形文件类型
        if ($this->fileclass == "images") {

            // 设置水印/微缩图
            if ($this->config['upload_water']) {
                $this->Images->watermark($this->resource,$this->config);
            }
            if ($this->config['upload_thumb'] || $avatar ){
				$this->Images->thumb($this->filepath, $this->filename, $this->config, $avatar);
			}
        }
        
		return $this->success('文件上传成功！','/'.$this->resource);   
    }


    /**
     * 文件下载函数
     */
    public function download(string|array $urls = null, bool $hosts = false)
    {
        if (!$urls) {
            return false;
        }

        if (!is_array($urls)) {
            $urls = explode(',',$urls);
        }

        $images = [];
        foreach ($urls as $key => $url) {

            # code...
            $file = pathinfo(trim($url));
            $ext  = $file['extension'];
            $token = strpos($ext,'?');

            if ($token) {
                $ext = substr($ext,0,$token);
            }
            
            //  获取地址参数
            $host = parse_url($url, PHP_URL_HOST);
            if ($host) {
                $host = explode('.',$host);
                $count = count($host);
                $host  = $count > 1 ? $host[$count - 2] . '.' . $host[$count - 1] : $host[0];
            }

            // 过滤本站链接
            $domain = request()->rootDomain();
            if (($host && $host !== $domain) ||($host && $hosts)) {

                $filter = $this->config['upload_class']['images'];
                if (!stripos($filter,strtolower($ext))) {
                    continue;
                }

                // 检测请求头
                $heads = @get_headers($url, true);
                if (empty($heads)) {
                    continue;
                } else if (!(stristr($heads[0], "200") && !stristr($heads[0], "304"))) {
                    continue;
                }

                // 从缓冲区读取
                ob_start();
                $context = stream_context_create(
                    array('http' => array(
                        'follow_location' => false
                    ))
                );

                readfile($url, false, $context);
                $content = ob_get_contents();
                ob_end_clean();

                $this->filename = uniqid().'.'.strtolower($ext);
                $this->filepath = $this->config['upload_path'].'/images/'.date($this->config['upload_style']); 
                $this->resource = $this->filepath .'/'. $this->filename;

                // 写入文件
                if (!write_file($this->resource,$content)) {
                    continue;
                }

                if ($this->config['upload_water']) {
                    $this->Images->watermark($this->resource,$this->config);
                }

                if ($this->config['upload_thumb'] && $key <= 0){
                    $this->Images->thumb($this->filepath, $this->filename, $this->config);
                }

                $images[$url] = '/'.$this->resource;
                // 上传阿里云/FTP空间
                if (!$this->uploadOss() || !$this->uploadFtp()) {
                    return false;
                }
            }
        }

        return $images;
    }

    protected function uploadOss()
    {
        if (saenv('cloud.status')) {

            if (!Event::hasListener('clouduploads')) {
                $this->setError('未安装云上传插件');
                return false;
            }

           try {
                // 开启云上传
                if (Event::trigger('clouduploads',[
                    'type'=>saenv('cloud.type'),
                    'object'=> $this->resource,
                    'filename'=> $this->resource
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
            $thumbfile = $this->filepath.'/thumb_'.$this->filename;
            if ($this->config['upload_ftp'] && is_file($thumbfile)) {
                $ftpstatus = Ftp::instance()->ftp_upload($thumbfile,$this->filepath,'thumb_'.$this->filename,$this->config);
            }
            
            $ftpstatus = Ftp::instance()->ftp_upload($this->resource,$this->filepath,$this->filename,$this->config);
			if ($ftpstatus) {

				// 删除本地文件
				if ($this->config['upload_del']) {
                    unlink($thumbfile);
                    unlink($this->resource);
                } 
			}
            else {

                $this->setError('文件上传至FTP服务器异常');
                return false;
			}
		}

        return true;
    }

    /**
     * 验证文件类型
     */
    public function filefilter($file) 
    {
        // 查找文件类型	
        foreach ($this->config['upload_class'] as $key => $value) {
            if (stripos($value,strtolower($file->extension()))) {
                $this->fileclass = $key;
                break;
            }
        }

        // 验证一句话木马 /*如果是加密的无法判断*/
        $tempFile = $file->getPathname();
        $content = @file_get_contents($tempFile);
        if (false == $content 
            || preg_match('#<\?php#i', $content) 
            || $file->getMime() == 'text/x-php' )  {
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
                $url = str_replace('http:','',$this->config['upload_http_prefix']).$url;
            }
        } catch (\Throwable $th) {
            echo $th->getMessage();
        }

        return ['code'=>200,'msg'=>$msg,'url'=>$url];
    }

    public function error($msg) {
        return ['code'=>101,'msg'=>$msg];
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