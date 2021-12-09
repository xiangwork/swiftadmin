<?php
declare (strict_types = 1);
namespace app\common\exception;

use Throwable;
use think\Response;
use think\exception\Handle;

class Provider extends Handle
{
    protected $error;

    public function render($request, Throwable $th): Response
    {
        /**
         * 默认捕获所有异常信息
         */
        if ($th instanceof \Throwable) {
            $status = saenv('system_log_status');
            if ($status && !empty($th->getMessage()) && $th->getLine() >= 1) {
                $systemlogs = get_system_logs();
                $systemlogs['type'] = 1;
                $systemlogs['file'] = $th->getFile();
                $systemlogs['line'] = $th->getLine();
                $systemlogs['error'] = $th->getMessage();
                \app\common\model\system\Systemlog::write($systemlogs);
            }
        }

        // 其他错误交给系统处理
        return parent::render($request, $th);
    }

}
