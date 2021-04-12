<?php
declare (strict_types = 1);

namespace app\common\validate\system;

use think\Validate;

class Comment extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
    protected $rule =   [
		'cid'	   => 'require|number',
		'sid'	   => 'require|number',		
        'content'  => 'require|max:120',
    ];
	
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message  =   [
        'cid.require'		=> '分类id错误',
        'cid.number'     	=> '分类id必须是数字',
        'sid.require'		=> '对象id不能为空',
        'sid.number'     	=> '对象id必须是数字',			
        'content.require'	=> '内容不得为空',
        'content.max'     	=> '评论内容最多不能超过120个字符',	
    ];
	
	// 验证场景
    protected $scene = [
        'ajax'  =>  ['cid','sid'],
    ];   	
}