<?php
declare (strict_types = 1);

namespace app\index\middleware;

class Template
{
    /**
     * 处理请求
     *
     * @param \think\Request $request
     * @param \Closure       $next
     * @return Response
     */
    public function handle($request, \Closure $next)
    {
        /**
         * 处理前端模板
         */
        if (saenv('site_state') && saenv('site_type')) {
            // $hosts  = request()->header()['host'];
            // $mobile = saenv('site_mobile');
            // $mobile = str_replace(['https://', 'http://', '://'], '', $mobile);
            // if ((request()->isMobile() && !$mobile) || ($mobile && $mobile == $hosts)) {
            //     $this->template  = root_path('app/mobile/view');
            //     app()->view->config(['view_path' => $this->template]);
            // }
        }

        return $next($request);
    }
}
