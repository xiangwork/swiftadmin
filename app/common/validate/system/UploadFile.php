<?php
declare (strict_types = 1);

namespace app\common\validate\system;

use think\Validate;

class UploadFile extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
		'images'=>[
			'fileSize' => 419430400,
			'fileExt' => 'jpg,jpeg,png,bmp,gif',
			'fileMime' => 'image/jpeg,image/png,image/gif'], // 这个一定要加上，很重要我认为！
		'video'=>[
			'fileSize' => 419430400,
			'fileExt' => 'flv,swf,mkv,avi,rm,rmvb,mpeg,mpg,ogg,ogv,mov,wmv,mp4,webm,mp3,wav,mid'],
		'document'=>[
			'fileSize' => 419430400,
			'fileExt' => 'txt,doc,xls,ppt,docx,xlsx,pptx'],
		'files'=>[
			'fileSize' => 419430400,
			'fileExt' => 'exe,dll,sys,so,dmg,iso,zip,rar,7z,sql,pem']
		];
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [];
}
