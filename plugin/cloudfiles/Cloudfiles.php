<?php

namespace plugin\Cloudfiles;

use think\plugin;

use OSS\OssClient;
use OSS\Core\OssException;
use Overtrue\CosClient\ObjectClient;
use Composer\Autoload\ClassLoader;

/**
 * 云上传插件
 */
class Cloudfiles extends plugin
{
    /**
     * 插件安装方法
     * @return bool
     */
    public function install()
    {
        return true;
    }

    /**
     * 插件卸载方法
     * @return bool
     */
    public function uninstall()
    {
        return true;
    }

    /**
     * 插件启用方法
     * @return bool
     */
    public function enable()
    {
        return true;
    }

    /**
     * 插件禁用方法
     * @return bool
     */
    public function disable()
    {
        return true;
    }

    /**
     * 插件初始化
     * @return bool
     */
    public function appInit() {

        try {
            if (!class_exists('OSS')) {
                $loader = new ClassLoader();
                $loader->addPsr4('OSS\\',PLUGIN_PATH.'cloudfiles/library/OSS');
                $loader->addPsr4('Overtrue\\CosClient\\',PLUGIN_PATH.'cloudfiles/library/qcloud');
                $loader->register(true);
            }
        } catch (\Throwable $th) {
        }
    }

    /**
     * 简易云上传函数
     */
    public function clouduploads($param)
    {
        $config = config('system.cloud.'.$param['type']);
        if ($param['type'] == 'aliyun')
        {
            try {
                // 阿里云SDK上传
                $ossClient = new OssClient($config['accessId'],$config['accessSecret'],$config['endpoint']);
                $ossClient->uploadFile($config['bucket'],$param['object'],$param['filename']);
            } catch(OssException $e) {
                throw new \Exception($e->getMessage());
                return false;
            }
        }
        else {
            try {
                $cosClient = new ObjectClient($config);
                $handle = @fopen($param['filename'],"r");
                $content = @fread($handle,filesize($param['filename']));
                $cosClient->putObject($param['object'],$content);
                @fclose($handle);
            } catch(\Throwable $th) {
                throw new \Exception($th->getMessage());
                return false;
            }
        }

        return true;
    }
}
