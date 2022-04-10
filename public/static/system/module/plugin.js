/* 插件管理模块 */
layui.define(['i18n'], function (exports) {

    var $ = layui.jquery;
    var table = layui.table;
    var i18n = layui.i18n;
    var form = layui.form;

    i18n.render(layui.admin.getStorage('language') || 'zh-CN');
    var area = [$(window).width() > 800 ? '660px' : '85%', $(window).height() > 800 ? '680px' : '85%'];

    var plugin = {
        apiUrl: _fr4mework.api,
        baseUrl: _fr4mework.app,
        install: function (name, token, url) {
            $.post(plugin.baseUrl + url, {
                name: name,
                token: token,
            }, function (res) {

                layer.closeAll();
                if (res.code == 200) {
                    layer.msg(res.msg);

                    var index = layui.sessionData('api_install_index').index,
                        elems = $('tr[data-index="' + index + '"]');
                    if (url.indexOf('install') != -1) {
                        var c = '', h = '<input type="checkbox" lay-filter="switchStatus" data-url="';
                        h += plugin.baseUrl + '/system.plugin/status" value="' + name + '" lay-skin="switch" checked="">';
                        h += '<div class="layui-unselect layui-form-switch layui-form-onswitch" lay-skin="_switch"><em></em><i></i></div>';
                        $(elems).find('[data-field="status"]').children('div').append(h);
                        data = res.data || [];
                        if (data.config) {
                            c += '<a class="layui-table-text" lay-title="' + i18n.prop('配置插件') + '"'
                            c += 'data-area="' + data.area + '" lay-maxmin="true"';
                            c += 'data-url="' + plugin.baseUrl + '/system.plugin/config/name/' + name + '" '
                            c += 'lay-event="edit">' + i18n.prop('配置') + '</a>';
                            c += '<div class="layui-divider layui-divider-vertical"></div> ';
                        }
                        c += '<a class="layui-table-text uninstall" style="color:red"'
                        c += 'data-url="' + plugin.baseUrl + '/system.plugin/uninstall/name/' + name + '">' + i18n.prop('卸载') + '</a> ';
                        $(elems).find('td:last').children('div').html(c);
                        window.plugins[name] = res.data;
                    } else {
                        elems.find('.layui-upgrade-elem').remove();
                        elems.find('.layui-form-switch').addClass('bubble');
                        elems.find('.layui-form-switch').trigger('click', ['stopPropagation']);
                    }

                    // 初始化菜单项

                } else {

                    layer.msg(res.msg, 'error');

                    // 登录超时
                    if (res.code == -101) {
                        plugin.login();
                        return false;
                    }

                    // 付费插件
                    if (res.code == -102) {
                        plugin.pay(res.data);
                        return false;
                    }
                }

            }, 'json');

        }
        , login: function () {

            layer.open({
                type: 1,
                title: '登录',
                shadeClose: true,
                area: ['500px', '350px'],
                content: plugin.getHtml(),
                success: function (index, layero) {
                    form.on('submit(login)', function (data) {
                        $.post(plugin.apiUrl + '/user/login',

                            data.field, function (res) {
                                if (res.code == 200) {
                                    layui.admin.setStorage('api_cross_token', res.data.token);
                                    layer.closeAll();
                                    plugin.againclick();
                                } else {
                                    layer.msg(res.msg, 'error');
                                }
                            }, 'json')

                        return false;
                    })
                }
            })
        }
        , clearLogin: function () {
            layui.admin.setStorage('api_cross_token', null);
        }
        , pay: function (data) {
            layer.open({
                type: 2,
                title: i18n.prop('立即支付'),
                area: area,
                offset: "30px",
                resize: false,
                shade: 0.8,
                shadeClose: true,
                content: data.payurl,
                success: function (index, layero) {
                    window.onmessage = function (res) {
                        var data = res.data;
                        if (res.data !== null && data.code == 200) {
                            layer.close(layero);
                            plugin.againclick();
                        }

                        if (res.data !== null && data.code == -133) {
                            layer.close(layero);
                        }
                    }
                }
            });
        }
        , againclick: function () {
            try {

                var index = layui.sessionData('api_install_index').index,
                    install = $('tr[data-index="' + index + '"]').children().find('.install');
                if (install.length <= 0) {
                    install = $('[layui-value="' + index + '"]');
                }
                if (install && index != null) {
                    $(install).trigger("click");
                }

            } catch (error) {
                console.log(error);
            }
        }
        , uninstall: function (name, tables) {
            var appURL = plugin.baseUrl;
            $.post(appURL + plugin.getUrl('plugin', 'uninstall'), {
                name: name,
                tables: tables,

            }, function (res) {

                if (res.code == 200) {
                    layer.msg(res.msg);
                    var index = layui.sessionData('api_install_index').index,
                        elems = $('tr[data-index="' + index + '"]');
                    $(elems).find('[data-field="status"]').children('div').html('');
                    var html = '<a class="layui-table-text install" data-url="' + appURL;
                    html += '/system.plugin/install/name/' + name + '">' + i18n.prop('安装') + '</a>';
                    var plugin = table.cache['lay-tableList'][index];
                    if (typeof plugin.demourl != 'undefined') {
                        html += '<div class="layui-divider layui-divider-vertical"></div>';
                        html += '<a class="layui-table-text" target="_blank" href="';
                        html += plugin.demourl + '">' + i18n.prop('演示') + '</a>';
                    }
                    delete window.plugins[name];
                    $(elems).find('td:last').children('div').html(html);

                    // 卸载完成
                    // 重新请求菜单

                } else {
                    layer.msg(i18n.prop(res.msg), 'error');
                }

                layer.close(window.unIndex);
            }, 'json');
        }
        , getUrl(type, action) {
            return '/system.' + type + '/' + action;
        }
        , getTableData: function (that) {

            if (that == null || that == 'undefined') {
                return false;
            }

            var index = $(that).parents('tr').attr('data-index');
            index = table.cache['lay-tableList'][index];
            return index;
        }
        , getHtml: function () {
            var html = '<form class="layui-form layui-form-fixed" style="padding-right:15px;" >';
            html += '<blockquote class="layui-elem-quote layui-elem-plugin">';
            html += '</blockquote><div style="height:20px;"></div>';
            html += '<div class="layui-form-item">';
            html += '<label class="layui-form-label">用户帐号</label>';
            html += '<div class="layui-input-block">';
            html += '<input type="text" name="nickname" style="width:330px;" lay-verify="required" placeholder="请输入邮箱或手机号" class="layui-input" >';
            html += '</div></div>';
            html += '<div class="layui-form-item"><label class="layui-form-label">密码</label>';
            html += '<div class="layui-input-block">';
            html += '<input type="password" name="pwd" style="width:330px;" lay-verify="required" placeholder="请输入密码" class="layui-input">';
            html += '</div></div>';
            html += '<div class="layui-form-item" style="margin-top: 22px;text-align: center;">';
            html += '<a class="layui-btn layui-btn-primary" href="http://www.swiftadmin.net/user/register" target="_blank">注册</a>';
            html += '<button type="submit" class="layui-btn layui-btn-normal" lay-submit lay-filter="login">登录</button>';
            html += '</div></form> ';
            return html;
        },
    };

    /**
     * 查询插件信息
     */
    $('.layui-plugin-select').click(function () {

        var that = $(this);

        if (that.hasClass('active') && !that.hasClass('first')) {
            that.removeClass('active');
            that.siblings('span.first').addClass('active');
        } else {
            that.siblings('.active').removeClass('active');
            that.addClass('active');
        }

        var data = {}, elem = $('.active');
        elem.each(function (e, n) {
            var value = $(n).attr('data-value') || ''
                , type = $(n).parent().attr('name');
            data[type] = value;
        })

        var b = ['type', 'pay', 'label'];

        for (let i in b) {
            if (!data[b[i]]) {
                data[b[i]] = '';
            }
        }

        table.reload('lay-tableList', {
            where: data,
            url: plugin.apiUrl + "plugin/index",
        });
    })

    /**
     * 安装/更新插件
     */
    $(document).on("click", ".install,.upgrade", function () {

        // 获取token
        var that = $(this),
            index = layer.load(),
            elem = that.attr('class'),
            type = that.attr('lay-type') || 'plugin',
            action = elem.replace('layui-table-text', '').replace(/(^\s*)|(\s*$)/g, ""),
            name = plugin.getTableData(this)['name'],
            token = layui.admin.getStorage('api_cross_token') || null;
        layui.sessionData('api_install_index', {
            key: 'index',
            value: plugin.getTableData(this)['LAY_TABLE_INDEX'],
        });

        if (token == null || token == 'undefined') {
            layer.close(index);
            plugin.login();
            return false;
        }

        if (action.indexOf('upgrade') != -1) {

            var tips = '<div class="lay-upgrade">确认升级《<font size="4">' + name + '</font>》插件？<br/>';
            tips += '<font color="red">1、请务必做好代码和数据库备份！</font><br/>';
            tips += '<font color="red">2、升级后如出现冗余数据，请根据需要移除即可！</font><br/>';
            tips += '<font color="red">3、生产环境下更新插件，请勿在流量高峰期操作！</font><br/></div>';
            var confirm = layer.confirm(tips, {
                title: i18n.prop('更新提示'),
            }, function () {
                layer.close(confirm);
                plugin.install(name, token, plugin.getUrl(type, action));
            }, function () {
                layer.close(index);
            });
        } else {
            plugin.install(name, token, plugin.getUrl(type, action));
        }

    })

    /**
     * 更改插件状态
     */
    form.on('switch(pluginStatus)', function (obj) {

        var that = $(this)
            , options = {
            error: function (res) {
                $(obj.elem).prop('checked', !obj.elem.checked);
                form.render('checkbox');
                layer.msg(res.msg, 'error');
            },
            success: function (res) {
                layer.msg(res.msg);
                window.plugins[data.id].status = data.status;
                // 关闭安装插件后
                // 需要重新请求菜单
            }
        } , data = {
            id: $(this).attr('value'),
            status: obj.elem.checked ? 1 : 0
        };

        if ($('.bubble').length) {
            $('.bubble').removeClass('bubble');
            return false;
        }

        layui.admin.event.request(that, data, options);
    });

    /**
     * 卸载插件
     */
    $(document).on("click", ".uninstall", function (obj) {

        var name = plugin.getTableData(this)['name'];
        var html = '<form class="layui-form layui-form-fixed" style="padding-right:15px;background: #f2f2f2;" >';
        html += '<blockquote class="layui-elem-quote layui-elem-uninstall">温馨提示<br/>';
        html += '确认卸载 《' + name + '》 吗？<br/>';
        html += '1、卸载前请自行备份插件数据库 ！<br/>';
        html += '2、插件文件及数据库表删除后无法找回 ！<br/>';
        html += '3、插件如已被二次开发，请自行清除冗余文件！<br/>';
        html += '</blockquote>';
        html += '<div class="layui-form-item">';
        html += '<div class="layui-input-inline" style="padding-left: 5px;">';
        html += '<input type="checkbox" lay-filter="tables" lay-skin="primary" title="删除插件相关数据库表" >';
        html += '<div class="layui-plugin-tables layui-badge-red"></div></div></div>';
        html += '<div class="layui-footer" style="margin-top: 22px;text-align: center;">';
        html += '<button type="submit" class="layui-btn layui-btn-normal" lay-submit lay-filter="start">确定</button>';
        html += '<button type="button" class="layui-btn layui-btn-primary" sa-event="closeDialog" >关闭</button>';
        html += '</div></form> ';
        layui.sessionData('api_install_index', {
            key: 'index',
            value: plugin.getTableData(this)['LAY_TABLE_INDEX'],
        });
        layer.open({
            type: 1,
            title: i18n.prop('卸载插件'),
            shadeClose: true,
            area: ['380px', '360px'],
            content: html,
            success: function (index, layero) {
                form.render();
                form.on('checkbox(tables)', function (data) {
                    if (data.elem.checked) {
                        $.get(plugin.baseUrl + '/system.plugin/tables', {
                            name: name
                        }, function (res) {
                            try {
                                if (res.code == 200 && res.data.tables) {
                                    var tables = [];
                                    var tips = '<span>即将删除数据表：</span>';
                                    $('.layui-plugin-tables').append(tips).show();
                                    for (var i in res.data.tables) {
                                        tables.push([res.data.tables[i]]);
                                        var table = '<span>' + res.data.tables[i] + '</span>、';
                                        $('.layui-plugin-tables').append(table);
                                    }
                                } else {
                                    layer.msg(res.msg, 'error');
                                }
                            } catch (error) {
                                console.log(error);
                            }
                        }, 'json');
                    } else {
                        $('.layui-plugin-tables').html('').hide();
                    }
                })

                // 请求服务器
                form.on('submit(start)', function (data) {

                    var tables = [];
                    var lists = $('.layui-plugin-tables').children('span');
                    lists.each(function (e, n) {
                        if (e >= 1) {
                            tables.push($(n).html());
                        }
                    })

                    window.unIndex = layer.load();
                    layer.close(layero);
                    plugin.uninstall(name, tables);
                    return false;
                })
            }
        })
    })

    /**
     * 本地安装插件
     */
    $('*[data-value=install]').click(function (res) {
        table.reload('lay-tableList', {
            url: plugin.baseUrl + '/system.plugin/index?type=install'
        });
    })

    /**
     * 更新插件缓存
     */
    $('*[data-value=cache]').click(function (res) {
        var confirm = layer.confirm('确定要更新缓存吗？', {
            title: '更新提示'
        }, function () {
            $.get(plugin.baseUrl + plugin.getUrl('admin', 'clear/type/plugin'), {}, function (res) {
                if (res.code == 200) {
                    layer.msg(res.msg);
                    layer.close(confirm);
                } else {
                    layer.msg(res.msg, 'error');
                }
            })
        });
    })

    /**
     * 插件幻灯片
     */
    $('body').on('click', '.layui-icon-picture', function (res) {

        var index = plugin.getTableData(this), data = [];
        if (index.album) {
            for (let i in index.album) {
                data.push({
                    src: index.album[i].src,
                    thumb: index.album[i].src,
                })
            }
        }

        layer.photos({
            photos: {data: data},
            shadeClose: true,
            closeBtn: 2,
            anim: 10
        })
    })

    exports('plugin', plugin);
});