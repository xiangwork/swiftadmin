/** SwiftAdmin iframe v1.0 date:2020-10-05 License By http://www.swiftadmin.net */

// 以下代码是配置layui扩展模块的目录，每个页面都需要引入
layui.config({
    version: true,
    base: getProjectUrl() + 'module/'
}).extend({
    step: 'step/step',
    iziToast: 'iziToast/iziToast',
    cascader: 'cascader/cascader',
    echarts: "echarts/echarts",
    fileManager: 'fileManager/fileManager',
    eleTree: "eleTree/eleTree",
    xmselect: 'xmselect/xmselect',
    treetable: 'treetable/treetable',
    tableSelect: 'tableSelect/tableSelect',
    iconHhysFa: 'iconHhys/iconHhysFa',
    notice: 'notice/notice',
}).use(['admin'], function () {
    var $ = layui.jquery;  // jquery的
    var admin = layui.admin; // amdin模块的
});

// 获取当前项目的根路径，通过获取layui.js全路径截取assets之前的地址
function getProjectUrl() {
    var layuiDir = layui.cache.dir;
    
    if (!layuiDir) {
        var js = document.scripts, last = js.length - 1, src;
        for (var i = last; i > 0; i--) {
            if (js[i].readyState === 'interactive') {
                src = js[i].src;
                break;
            }
        }
        var jsPath = src || js[last].src;
        layuiDir = jsPath.substring(0, jsPath.lastIndexOf('/') + 1);
    }

    return layuiDir.substring(0, layuiDir.indexOf('layui'));
}

/*公共库函数*/
