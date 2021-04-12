<?php

namespace plugin\cloudfiles\controller;



use Overtrue\CosClient\ObjectClient;

use think\plugin\PluginController;


class Index extends PluginController {

   

    public function index() {

        $config = config('system.cloud.qcloud');
        $cosClient = new ObjectClient($config);
        $handle = @fopen('upload/avatar/a0b923820dcc509a_100x100.png',"r");
        $content = @fread($handle,filesize('upload/avatar/a0b923820dcc509a_100x100.png'));
        // halt($content);
        @fclose($handle);

        /**
         * 默认判断是否异常来解决这个问题
         */
        $result = $cosClient->putObject('123.png',$content)->isXML();

        halt($result);
        
       
    }



}