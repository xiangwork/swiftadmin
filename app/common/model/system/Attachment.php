<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
/**
 * @mixin \think\Model
 */
class Attachment extends Model
{

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    /**
     * 获取文件大小
     * @access      public
     * @return      string
     */
    public function getFilesizeAttr($filesize) 
    {
        if (!empty($filesize)) {
            return format_bytes($filesize);
        }
        return $filesize;
    }

}
