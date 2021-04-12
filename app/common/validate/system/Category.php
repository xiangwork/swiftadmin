<?php
declare (strict_types = 1);

namespace app\common\validate\system;

use think\Validate;

class Category extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
    protected $rule =   [
        'title'  => 'require|max:32|isNumeric',
        'pid'    => 'notEqId',
    ];
	
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message  =   [
        'title.require'		 => '栏目名称必须',
        'title.max'     	 => '名称最多不能超过32个字符',
        'title.isNumeric'    => '栏目名称不能为纯数字',		
        'pid.notEqId'        => '选择上级分类错误！',		
    ];
	
	// 自定义验证规则
	protected function isNumeric($value) 
    {
        if(is_numeric($value) && is_int($value +0)
			&& ($value +0)>0){
            return false;
        }else{
            return true;
        }
    }
    
    // 分类错误
    protected function notEqId($value, $rule, $post) 
    {
        if ($value == $post['id']) {
            return false;
        }
        return true;
    }
}
