## 安装
1、首先将本框架直接clone到你本地,或者直接下载
```sh
git clone https://gitee.com/meystack/swiftadmin.git
```
2、以宝塔面板为例：将你的网站访问目录修改为public文件夹
```sh
请自行安装宝塔面板，并做好伪静态等相关配置！
```
3、在根目录直接执行 composer install 命令加载第三方库即可！
```sh
composer install
```
或者使用一键安装命令 请确保你的机器上安装了 Composer

通过 Composer 来管理依赖，Linux系统请sudo composer install

```sh
git clone https://gitee.com/meystack/swiftadmin.git ./src && cd src && composer install
```
## 环境部署
SAPHP的运行环境为PHP7 PHP8 + MYSQL 5.7以上版本，并且请安装Composer

系统的session默认使用TP缓存模式，如自建服务器请优先使用redis缓存服务

## 开发规范


::: tip 提示
请遵循ThinkPHP框架的开发规范，以下是SAPHP框架的避免踩坑集锦！
::: 

* 在开发的过程中，请开启DEBUG模式
* 在开发的过程中，请保持写文档的习惯，因为SWIFTADMIN的认证机制，所以你需要记载每一个控制器的函数。
* 因为大多数情况下都是需要鉴权的，理论下你每个接口都需要填写到菜单里面，记录下来是为了让自己更方便查找！
> 如果你嫌麻烦可以直接在后台基础控制器里面进行配置！

* 尽量避免接口鉴权问题，因为后期菜单接口会出现很多，这个一般会出现在页面层，比如说，

* 你需要实时的调用一些接口用来返回JSON数据，为了没有必要添加多个接口鉴权，推荐采用iframe层的方式进行数据的添加和修改，

* 例如swiftAdmin框架的栏目添加。另外如果你已经习惯了在页面层进行数据的添加！

> 那么在调用数据的时候

* 如果数据量比较少并且是不变的，比如年级，分级制度，请在index方法展示得时候进行页面渲染输出即可
* 如果你的数据是经常需要变化的，由于是页面层，那么建议你在每个操作对应的方法中，增加参数判断来输出信息，
* 例如我需要POST ADD方法，那么请在add方法中增加一个函数判断！并且还需要自己去实现打开窗口回调函数的实现进行数据组件的渲染。请参考导航管理！ 额外模板变量，系统已经为你准备了一个公司信息模块，你完全可以使用标签调用这个函数，如果当前公司模块数据不符合你的要求 建议你做如下操作，如果是系统的属性，那么请在基础配置里面增加 修改模板就行，如果是公司的属性，请在公司模块里面进行修改！！

::: warning 提示
当我们需要操作的页面数据比较混杂的时候，建议使用iframe层，虽然需要打开一个页面。但是做数据渲染比较方便，因为毕竟我们这个版本不是前后端分离，
:::

## 目录结构
::: details 点击查看代码
```js
app
├── .htaccess
└── admin
	├── common.php
	└── config
  ├── app.php
	└── controller
  ├── Index.php
  ├── Login.php
  └── system  // 系统控制权
  ├── Tpl.php
  ├── Upload.php
	├── event.php
	└── lang
	└── middleware
	├── middleware.php
	└── view
├── AdminController.php
└── api
├── AppService.php
├── BaseController.php
└── common    	// 公共模块
├── common.php
├── event.php
├── ExceptionHandle.php
├── HomeController.php
└── index    	// 前端模块
└── install    // 安装模块
├── middleware.php
├── provider.php
├── Request.php
├── service.php
├── composer.json
├── composer.lock
├── composer.phar
└── config
└── error
└── extend
├── index.html
├── LICENSE.txt
├── nginx.htaccess
└── plugin
└── public
├── README.md
└── route
└── runtime
├── think
└── vendor
```
:::


## 系统配置
### 多语言
1、系统使用THINKPHP原生的多语言功能

2、系统默认的多语言为中文

3、如果需要其他语言，请遵循Thinkphp原生文档

### 开发说明
1、所有控制器需要返回的消息数据，统一使用__(消息字符)返回。

2、所有后台模板展示的数据，统一使用__(字符)返回;

3、所有其他需要用到语言转换的地方，请使用__(字符)返回;

4、前端渲染模板需要使用基类的view方法进行渲染，方便做视图过滤。

* 这样做的好处就是，当前的系统开发默认语言环境为中文，后期如果你需要多语言了，请自行制作语言包即可！

* 系统默认只是增加了一些简单的多语言配置文件，当你需要多语言配置的时候，请尽量使用语句较短的进行替换，过长会导致排版错位！
  
5、系统的模型管理，统一兼容CONTENT表，模型表只是当做主表的附加属性来使用，如果你需要设置独立的模型的话，请勿将例如房产模型；写入到模型表中，
> 也就是说，除了系统默认的 下载 图片 产品 影视等模型外，类似于 小说模型 等类似附加属性的，建议增加到模型当中去！

### 缓存配置
建议使用redis缓存来进行数据存取，另外只有redis缓存支持库的选择1-16，

系统默认使用system_cache函数来读取缓存，这个函数其实是cache函数的翻版

你可以增加域名前缀，这样首先是为了防止在同一个库文件里面出现缓存覆盖的问题，

另外支持select参数来进行库选择，这样相同的服务器基本上不会存在缓存被覆盖掉的问题！

### 日志管理
建议只开启错误日志记录，日常的操作日志可以不记录，开启错误日志主要是为了排查系统上线后会出现哪些BUG

以及当系统被人恶意扫描和入侵的时候，记录日志方便你进行代码的排查和修复！！！

### 短信发送
> 短信已经为大家写好了阿里云和腾讯云的接口，但是因为两个接口的差异化，所以你需要做一个测试。
``` php
/**
* 修改手机号
*/
public function mobile() 
{

    if (request()->isPost()) {

        $mobile = input('mobile');
        $captcha = input('captcha');
        if ($mobile && UserModel::getByMobile($mobile)) {
            return $this->error("您输入的手机号已被占用！");
        }

        // 校验验证码
        $instance = Sms::instance();
        if (!empty($mobile) && !empty($captcha)) {
            // 查找事件
            if ($instance->check($mobile, "changer")) {
                $instance->objectValidate->delete();
                $this->model->update(['id'=>$this->userId,'mobile'=>(int)$mobile]);
                return $this->success('修改手机号成功！');
            }

            return $this->error($instance->getError());
        }
        if ($instance->changer($mobile,'changer')) {
            return $this->success("验证码发送成功！");
        }
        else {
            return $this->error($instance->getError());
        }
    }
}
```
请参考上述代码修改短信发送的逻辑！

### 接口管理
1、系统默认集成了前端API调用的示例，你可以在此基础上修改代码完成你的业务流程。

2、API AUTH鉴权类默认开启了列表缓存，也就是说针对某个用户的权限节点会缓存在redis中。

3、因为系统开启了节点缓存，所以默认情况下，当你修改了某个用户针对某个API接口的调用规则的时候，不会立刻生效。<br> 需要你自己手动实现清理缓存的代码，当然如果你的工程不需要太苛刻的效率，可以注释掉缓存的代码！
``` php
public function getAuthList() {

    // 读取用户ID
    $where['user.app_id'] = $this->params['app_id'];
    $where['user.app_secret'] = $this->params['app_secret'];
    $this->nodeshash = md5short(implode('.',$where));
    $list = cache($this->nodeshash);

    if (empty($list)) {
        $list = Db::view('user','id')
                    ->view('api_access','*','api_access.uid=user.id')
                    ->view('api','class','api.id=api_access.api_id')
                    ->where($where)->select()->toArray();
        // 默认开启缓存 // 需手动控制修改缓存
        cache($this->nodeshash, $list, config(CACHETIME));
    }

    return $list ?? [];
}

if (!function_exists('clear_api_cache')) {
    /**
        * 清理用户API权限缓存
        */
    function clear_api_cache($token = null){

    if (is_array($token)) {
        $token = $token['app_id'].'.'.$token['app_secret'];
    }

    cache(md5short($token),null);
    }
}
```