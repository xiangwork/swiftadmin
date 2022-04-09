"use strict";

/*
    *SwiftAdmin 前端模块
    由于前端样式有些地方可能并不符合你已有的模板样式，
    所以此style和js文件仅供参考调用使用。
    在你实际的项目中，请参考一下示例重写模板文件。
*/
layui.use(['jquery', 'layer', 'element', 'form'], function () {

    var $ = layui.jquery;
    var layer = layui.layer;
    var form = layui.form;
    var element = layui.element;

    // 点击发送验证码
    $('#captcha').click(function() {

        let mobile = $('#mobile').val();
        if (!mobile) {
            return layer.msg('请输入手机号','error');
        }

        $.get('/api.php/ajax/smssend',{
            mobile: mobile,
            event : 'register'
        }, function(res) {
            if (res.code == 200) {
               layer.msg(res.msg);
            } else {
                layer.msg(res.msg,'error');
            }
        })
    })

    // cookie
    const Cookie = { // 获取cookies
        'Set': function (name, value, days) {
            var exp = new Date();
            exp.setTime(exp.getTime() + days * 24 * 60 * 60 * 1000);
            var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
            document.cookie = name + "=" + escape(value) + ";path=/;expires=" + exp.toUTCString();
        },
        'Get': function (name) {
            var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
            if (arr != null) {
                return unescape(arr[2]);
                return null;
            }
        },
        'Del': function (name) {
            var exp = new Date();
            exp.setTime(exp.getTime() - 1);
            var cval = this.Get(name);
            if (cval != null) {
                document.cookie = name + "=" + escape(cval) + ";path=/;expires=" + exp.toUTCString();
            }
        }
    }

    // 全局事件调用
    const event = {
        closeDialog: function (that) {

            that = that || this;
            var _type = $(that).parents(".layui-layer").attr("type");
            if (typeof _type === "undefined") {
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {

                var layerId = $(that).parents(".layui-layer").attr("id").substring(11);
                layer.close(layerId);
                top.layer.close(layerId);
            }
        }
    }

    // 默认监听的操作开始
    $(window).scroll(function () {
        var a = $(window).scrollTop();
        if (a >= 50) {
            $("#header").addClass("layui-nav-scroll")
        } else {
            $("#header").removeClass("layui-nav-scroll")
        }
    });

    // 监听form表单
    form.on('submit(submitIframe)', function (data) {
        var that = $(this), _form = that.parents('form'),
            _url = _form.attr("action") || false;
        $.post(_url,
            data.field, function (res) {
                if (res.code == 200) { // 存在URL属性则跳转
                    top.layer.msg(res.msg, function () {
                        if (res.url != "" || res.url != null) {
                            top.location.href = res.url;
                        }

                        event.closeDialog(that);
                    });
                }
                else {
                    top.layer.msg(res.msg,'error');
                }
            }, 'json');
        return false;
    });


    // 监听打开窗口
    $(document).on('click', "*[lay-open]", function () {
        var clickthis = $(this),
            config = {
                url: clickthis.attr('lay-url') || undefined,
                type: clickthis.attr('lay-type') || 2,
                area: clickthis.attr('lay-area') || "auto",
                offset: clickthis.attr('lay-offset') || "25%",
                title: clickthis.attr('lay-title') || false,
                maxmin: clickthis.attr('lay-maxmin') || false,
                auto: clickthis.attr('lay-auto') || "undefined",
            }

        if (config.url.indexOf('#') !== -1 || config.url.indexOf('.') !== -1) {
            if (config.url.indexOf('http://') === -1 && config.url.indexOf('.php') === -1) {
                config.type = 1;
                config.url = $(config.url).html();
            }
        }

        // 配置窗口大小
        if (config.area !== "auto") {
            config.area = config.area.split(',');
        }

        // 打开窗口
        layer.open({
            type: config.type,
            area: config.area,
            title: config.title,
            offset: config.offset,
            maxmin: config.maxmin,
            shadeClose: true,
            scrollbar: false,
            content: config.url,
            success: function (layero, index) {

                if (config.type === 1) {
                    form.render();
                    form.on("submit(submitPage)", function (post) {
                        var that = $(this), _pageUrl = that.parents('form').attr('action');
                        // 开始POST提交数据
                        $.post(_pageUrl,
                            post.field, function (res) {

                                if (res.code == 200) {
                                    event.closeDialog(that);
                                    top.layer.msg(res.msg);
                                }
                                else {
                                    top.layer.msg(res.msg,'error');
                                }

                            }, 'json');

                        return false;
                    })
                }
            }
        })
    })

    /**
     * 监听form表单搜索
     */
    form.on('submit(formSearch)', function (data) {

        var field = data.field;
        for (const key in field) {
            if (!field[key]) {
                delete field[key];
            }
        }

        layui.table.reload('lay-tableList', {
            page: { curr: 1 },
            where: field
        });
    })

    // 监听ajax操作
    $(document).on("click", "*[lay-ajax]", function (obj) {

        var clickthis = $(this), config = {
            url: clickthis.attr('lay-url') || "undefined",
            type: clickthis.attr('lay-type') || 'post',
            dataType: clickthis.attr('lay-dataType') || 'json',
            timeout: clickthis.attr('lay-timeout') || '6000',
            tableId: clickthis.attr('lay-table') || clickthis.attr('lay-batch'),
            reload: clickthis.attr('lay-reload') || false,
        }, defer = $.Deferred();

        // 定义初始化对象
        var data = {}

            // 获取拼接参数
            , packet = clickthis.attr("lay-data") || null
            , object = clickthis.attr("lay-object") || undefined;

        // 传递类数据
        if (typeof object !== "undefined") {
            object = object.split(',');
            for (var i = 0; i < object.length; i++) {
                let ele = object[i].split(":");
                var val = $('.' + ele[1]).val();
                data[ele[0]] = val;
            }
        }

        // 传递对象数据
        if (packet !== 'null') {
            packet = new Function("return " + packet)();
            data = $.extend({}, data, packet);
        }

        // 传递input表单数据
        var input = clickthis.attr('lay-input') || undefined;
        if (typeof input !== undefined) {
            var attribute = top.layui.jquery('.' + input).val();
        }

        // 执行AJAX操作
        $.ajax({
            url: config.url,
            type: config.type,
            dataType: config.dataType,
            timeout: config.timeout,
            data: data,
            success: function (res) {

                if (res.code == 200) {
                    if (config.reload) {
                        location.reload();
                    }
                    top.layer.msg(res.msg);
                }
                else {
                    top.layer.msg(res.msg,'error');
                }

            },
            error: function (res) {
                top.layer.msg('Access methods failure');
            }
        })
    })

    // 点击QQ登录 关闭自身
    $('.login-link a,.layui-bind-third').click(function () {
        var type = $(this).attr('data-url');
        parent.layer.open({
            type: 2,
            area: ['600px', '600px'],
            title: false,
            scrollbar: true,
            shadeClose: true,
            closeBtn: 0,
            content: [type, 'no'],
            success: function (layero, index) {
                // TODO...
                var index = layer.getFrameIndex(window.name);
                parent.layer.close(index);
            }
        });
    })
})

function openWindow(obj) {
    window.open(layui.$(obj).attr("data-url"), "_blank", "width=600,height=600,top=100px,resizable=no")
}
