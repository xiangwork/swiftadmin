## 前言
全文检索技术，尤其是中文全文检索技术的研究始于1987年左右，已经有一些商品化的软件。Internet的普及使得全文检索技术日益成熟起来，其应用已突破传统的情报部门和信息中心的局限性，使该技术的最广大用户变成互联网的用户和桌面用户，而不再仅局限于情报检索专家。

全文检索技术以各类数据如文本、声音、图像等为对象，提供按数据的内容而不是外在特征来进行的信息检索，其特点是能对海量的数据进行有效管理和快速检索。它是搜索引擎的核心技术，同时也是电子商务网站的支撑技术。全文检索技术可应用于企业信息网站、媒体网站、政府站点、商业网站、数字图书馆和搜索引擎中。我们知道，企业信息化是电子商务的基础，企业建立自己的商务站点，构建企业内部信息发布平台，并与其他网站间建立安全的信息发布通道和交换通道，建立电子商务的应用并以数据为中心建立应用平台等方面都离不开全文检索。该检索技术可跨越所有的数据源，支持多种数据和信息格式，对检索结果可按商业分类规则进行排列，也能满足用户特定的知识检索请求，将所有不同信息查询中的命中结果按相关性或分类排列，提供不同格式的信息浏览功能。

从搜索结果来源的角度，全文搜索引擎又可细分为两种，一种是拥有自己的检索程序（Indexer），俗称“蜘蛛”（Spider）程序或“机器人”（Robot）程序，并自建网页数据库，搜索结果直接从自身的数据库中调用，如Google、Fast/AllThe Web、AltaVista、Inktomi、Teoma、WiseNut、百度等；另一种则是租用其他引擎的数据库，并按自定的格式排列搜索结果，如Lycos引擎。

::: tip 提示
当前业界最火的搜索引擎当属ElasticSearch，基于ES的集群服务可轻松承载PB级别的数据。
::: 
## XunSearch
Xunsearch 是一个高性能、全功能的全文检索解决方案。

Xunsearch 中文译名为“迅搜”，代码中的经常被缩写为 XS，既是英文名称的缩略也是中文声母缩写。 这儿的“迅”是快速的意思，至少包含了两层涵义：其一代表了搜索结果的响应能力，其二则为二次开发难度、速度。

Xunsearch 采用结构化分层设计，包含后端服务、前端开发包两大部分，层次清晰而不交叉。 其中后端是采用 C/C++ 编写的守护进程，而前端采用最为流行的脚本语言 PHP ，对于 web 搜索项目更为方便。 具体参见架构设计。

Xunsearch 极大程度降低的搜索开发的难度，除了常规的中文分词、字段检索、布尔语法等功能外， 还比其它免费的解决方案提供了用户急需的相关搜索、拼音搜索、结果高亮、搜索建议等等。 具体的清单请参见我们的功能列表。

Xunsearch 真正全面开源，并使用最流行的开源许可协议 GPL 发布。您可以免费获取本项目的全部源代码， 自由的使用它，并在许可条件下修改和再分发，具体参见授权声明文件。

前提是要有一定的 PHP (或其它对应的 SDK 语言) 开发能力，并备有 Unix 类型操作系统的服务器至少一台。

`Xunsearch` 可以帮助您建立各种行业门户/垂直搜索、BBS 论坛搜索、CMS/Web站内搜索、文档/文献资料检索， 以及各种基于现有数据库系统的全文检索。

### 安装

::: danger 提示
官网的版本已经不适合安装在最新的Linux操作系统上了，请下载`SAPHP-xunsearch1.4.15`修改版
:::

> 请在安装之前确保你的Linux服务器环境下已经安装了相关依赖，

``` sh

1、如果你的Linux系统为新安装的，无wget命令，请安装wget

yum install wget -y

2、修改依赖源地址为阿里源地址，

wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && yum makecache fast

3、安装xunsearch 所需依赖
yum install -y gcc make kernel-headers kernel-devel  zlib-devel gcc-c++ libevent bzip2

4、下载安装包 并启动安装
wget https://www.swiftadmin.net/tools/xunsearch-1.4.15.tar.gz && tar  -xvf  xunsearch-1.4.15.tar.gz && cd xunsearch-1.4.15 && sh setup.sh

- 注意：
	安装脚本默认启动的服务是本地的模式，也就是 /usr/local/xunsearch/bin/xs-ctl.sh  start

	如果你是非本机访问xunsearch的话，请监听在IP上，格式为 /usr/local/xunsearch/bin/xs-ctl.sh -b 192.168.220.103 start

	请区分内外网的IP地址，比如访问会出错的。
```
::: tip 安装进度
  默认按照下面的代码回显，说明正常没问题，如果有报错或缺少相关的错误，请依据错误信息作相关的调整
:::

``` js
Please specify the installation directory
请指定安装目录 (默认为中括号内的值)
[/usr/local/xunsearch]:

Confirm the installation directory
请确认安装目录：/usr/local/xunsearch [Y/n]

Checking scws ... no
Installing scws (1.2.3) ... 
Extracting scws package ...
Configuring scws ...
Compiling & installing scws ... 
Checking scws dict ... no
Extracting scws dict file ... 
Checking libuuid ... yes: /usr
Checking xapian-core-scws ... no
Installing xapian-core-scws (1.4.17) ... 
Extracting xapian-core-scws package ...
Configuring xapian-core-scws ...
Compiling & installing xapian-core-scws ...
Checking libevent ... no
Installing libevent (2.1.11-stable) ... 
Extracting libevent package ...
Configuring libevent ...
Compiling & installing libevent ...
Extracting xunsearch package (1.4.15) ...
Configuring xunsearch ...
Compiling & installing xunsearch ...
Cleaning ... done
正在启动服务...
WARNING: no server[xs-indexd] is running (BIND:127.0.0.1:8383)
INFO: re-starting server[xs-indexd] ... (BIND:127.0.0.1:8383)
WARNING: no server[xs-searchd] is running (BIND:127.0.0.1:8384)
INFO: re-starting server[xs-searchd] ... (BIND:127.0.0.1:8384)
正在加入开机启动服务...

+=================================================+
| 如开启集群服务，请确保当前启动方式是否正确      |
+-------------------------------------------------+
| 说明和注意事项：                                |
| 1. bin/xs-ctl.sh -b local start                 |
|    监听在本地回环地址 127.0.0.1 上              |
|                                                 |
| 2. bin/xs-ctl.sh -b inet start                  |
|    监听在所有本地 IP 地址上                     |
|                                                 |
| 3. bin/xs-ctl.sh -b a.b.c.d start               |
|    监听在指定 IP 上                             |
|                                                 |
| 4. bin/xs-ctl.sh -b unix start                  |
|    分别监听在 tmp/indexd.sock和tmp/searchd.sock |
+=================================================+


+=================================================+
| Installation completed successfully, Thanks you |
| 安装成功，感谢选择和使用 xunsearch              |
+-------------------------------------------------+
| 说明和注意事项：                                |
| 1. 开启/重新开启 xunsearch 服务程序，命令如下： |
|    /usr/local/xunsearch/bin/xs-ctl.sh restart
|    强烈建议将此命令写入服务器开机脚本中         |
|                                                 |
| 2. 所有的索引数据将被保存在下面这个目录中：     |
|    /usr/local/xunsearch/data
|    如需要转移到其它目录，请使用软链接。         |
|                                                 |
| 3. 您现在就可以在我们提供的开发包(SDK)基础上    |
|    开发您自己的搜索了。                         |
|    目前只支持 PHP 语言，参见下面文档：          |
|    /usr/local/xunsearch/sdk/php/README
+=================================================+

[root@iZ2zebrrpkrdeoeqnxitriZ xunsearch-1.4.15]# 
```

### 建立索引
> 安装成功之后，就可以在SACMS的后台去创建XunSearch的索引服务

<img :src="$withBase('/images/xunsearch_create.png')" alt="创建字段">

### 字段配置
> 添加必要的字段信息，这个字段你可以依据自己的需求添加，但这上面的字段是必须要存在的

<img :src="$withBase('/images/xunsearch_field.png')" alt="创建字段">

### 导入数据

::: warning 
  因迅搜自带的数据导入脚本存在一定问题，请使用SAPHP修改后的数据导入脚本，在工程的根目录下有一个XunSearch的脚本文件，可在命令下直接执行
:::

> 如果你想把迅搜(XunSearch)集成到其他的第三方系统中去，推荐使用SAPHP扩展目录下的类文件进行相关的操作，
> 
>  <font color="red">软件中 app/common/library/XunSearch.php 通用接口类，请保留作者版权和代码注释信息（软件整体已申请著作权）</font>

``` php
// 在后台创建索引完毕后，执行清空索引
php xunsearch index --clean content

// 导入数据库
php xunsearch index --source=mysql://root:123456@127.0.0.1:3306/weikedb --sql="
SELECT c.id,c.pid,c.cid,c.access,c.title,t.content,c.hits,from_unixtime(c.createtime,'%Y-%m-%d %H:%i:%s') as createtime 
FROM sa_content c INNER JOIN sa_content_attr t ON t.content_id=c.id" --project=content

// 小提示
* 代码导入脚本，为了可以正常的获取扩展表的字段，会默认增加前缀
/**
 * 返回一批数据
 * @return 结果数组, 没有更多数据时返回 false
 */
protected function getDataList()
{
  if ($this->limit <= 0) {
    return false;
  }

  // 重写SQL语句快速导入索引
      $wheresql = " where c.id > ".$this->previd." order by c.id asc";
      if(stripos($this->sql, "where") >0){
        $wheresql=" and c.id > ".$this->previd." order by c.id asc";
      }
      $sql = $this->sql .$wheresql. ' LIMIT ' . min(self::PLIMIT, $this->limit) . ' OFFSET ' . $this->offset;
      $this->limit -= self::PLIMIT;
      return $this->db->query($sql);
}

```

## ElasticSearch
Elasticsearch 是一个分布式、高扩展、高实时的搜索与数据分析引擎。它能很方便的使大量数据具有搜索、分析和探索的能力。充分利用Elasticsearch的水平伸缩性，能使数据在生产环境变得更有价值。Elasticsearch 的实现原理主要分为以下几个步骤，首先用户将数据提交到Elasticsearch 数据库中，再通过分词控制器去将对应的语句分词，将其权重和分词结果一并存入数据，当用户搜索数据时候，再根据权重将结果排名，打分，再将返回结果呈现给用户。

Elasticsearch是与名为Logstash的数据收集和日志解析引擎以及名为Kibana的分析和可视化平台一起开发的。这三个产品被设计成一个集成解决方案，称为“Elastic Stack”（以前称为“ELK stack”）。

Elasticsearch可以用于搜索各种文档。它提供可扩展的搜索，具有接近实时的搜索，并支持多租户。Elasticsearch是分布式的，这意味着索引可以被分成分片，每个分片可以有0个或多个副本。每个节点托管一个或多个分片，并充当协调器将操作委托给正确的分片。再平衡和路由是自动完成的。相关数据通常存储在同一个索引中，该索引由一个或多个主分片和零个或多个复制分片组成。一旦创建了索引，就不能更改主分片的数量。
Elasticsearch使用Lucene，并试图通过JSON和Java API提供其所有特性。它支持facetting和percolating，如果新文档与注册查询匹配，这对于通知非常有用。另一个特性称为“网关”，处理索引的长期持久性；例如，在服务器崩溃的情况下，可以从网关恢复索引。Elasticsearch支持实时GET请求，适合作为NoSQL数据存储，但缺少分布式事务。


* 可以在笔记本电脑上运行。也可以在承载了 PB 级数据的成百上千台服务器上运行。<br/>
* 无论 Elasticsearch 是在一个节点上运行，还是在一个包含 300 个节点的集群上运行，您都能够以相同的方式与 Elasticsearch 进行通信。<br/>
* 它能够水平扩展，每秒钟可处理海量事件，同时能够自动管理索引和查询在集群中的分布方式，以实现极其流畅的操作。<br/>
### 安装
---
  安装elasticsearch,支持7.5+以上的版本

::: tip 提示
  如此傻瓜化的安装方式，以至于我都不想写文档去阐述他 <br/>
  请自行到官方下载对应的版本，然后修改配置文件，执行BAT或者SH文件，启动服务。<br/>
  需要注意的是 安装ElasticSearch的时候，请一并下载IK分词器插件，最好你可以有一个自己归类的字典
:::

### 建立索引
---
> 安装成功之后，如果你直接在kibana创建索引和mapping的话，请关闭全文索引后，再去创建相关的字段信息

<img :src="$withBase('/images/elasticsearch_create.png')" alt="创建字段">

### 字段配置
---
> 添加必要的字段信息，因为有些字段在全文检索的时候，需要判断一些鉴权或分类的操作，所以是必选的。

<img :src="$withBase('/images/elasticsearch_field.png')" alt="创建字段">

### 数据导入
---

::: tip 提示
  MySQL数据导入到ElasticSearch里面，使用阿里云开源版DataX工具进行处理。
:::

1、请在 https://github.com/alibaba/DataX 下载对应的版本

``` sh
wget http://datax-opensource.oss-cn-hangzhou.aliyuncs.com/datax.tar.gz
```

2、因为默认DataX是不包含elasticsearch的写入模块的，elasticsearchwriter

``` json
// 请自行打包文件，方便你DIY
// elasticsearchwriter源码还是很易读的
git clone https://github.com/alibaba/DataX.git
<modules>
        <module>common</module>
        <module>core</module>
        <module>transformer</module>
        <!-- reader -->
        <module>mysqlreader</module>
        <!-- writer -->
        <module>elasticsearchwriter</module>
        <!-- common support module -->
        <module>plugin-rdbms-util</module>
        <module>plugin-unstructured-storage-util</module>
        <module>hbase20xsqlreader</module>
        <module>hbase20xsqlwriter</module>
</moudles>
mvn clean install -Dmaven.test.skip=true
复制打好的包/elasticsearchwriter/target/datax/plugin/writer/elasticsearchwriter目录到datax的plugin目录下
```
::: danger
默认自行编译的elasticsearchwriter有两个问题

1、设置主键后，默认的主键字段丢失，无法获取ES返回结果使用ID进行in查询。虽然可控，但不建议<br/>
2、从数据库导入数据到ES，content内容字段，无法自动祛除TAG标签，虽然可以用`transformer`祛除，但转义的很麻烦<br/>
3、另外DataX的py执行脚本，到现在还是2.7的，还不支持3.x版本<br/>

:::
``` json
  // 贴出代码
  // 处理一些简单的逻辑还是可以的
 "transformer": [
      {
          "name": "dx_groovy",
          "parameter": {
              "code": "Column column = record.getColumn(0);String oriValue = column.asString();if(oriValue){String newValue = oriValue.replaceAll('<[^>]+>','');record.setColumn(0, new StringColumn(newValue));};return record;",
              "extraPackage": []
          }
      }
  ]
```

### 编写脚本
---
``` json
{
    "job": {
        "setting": {
            "speed": {
                 "channel": 3
            },
            "errorLimit": {
                "record": 0,
                "percentage": 0.02
            }
        },
        "content": [
            {
                "reader": {
                    "name": "mysqlreader",
                    "parameter": {
                        "username": "root",
                        "password": "123456",
                        "connection": [
                            {
                                "querySql": ["SELECT c.id,c.pid,c.cid,c.access,c.title,t.content,c.hits,from_unixtime(c.createtime,'%Y-%m-%d %H:%i:%s') as createtime FROM sa_content c INNER JOIN sa_content_attr t ON t.content_id=c.id"],
                                "jdbcUrl": ["jdbc:mysql://127.0.0.1:3306/weikedb"]
                            }
                        ]
                    }
                },
               "writer": {
				  "name": "elasticsearchwriter",
				  "parameter": {
					"endpoint": "http://127.0.0.1:9200",
					"accessId": "elastic",
					"accessKey": "123456",
					"index": "content",
					"type": "_doc",
                    "settings": {
                        "index": {
                            "number_of_shards":  3, 
                            "number_of_replicas": 1 
                        }
                    },
					"cleanup": false,
					"dynamic": true,
					"batchSize": 1000,
					"column": [ 
						{
							"name": "id", 
							"type": "id"
						}, 
						{
							"name": "pid", 
							"type": "long"
						}, 
						{
							"name": "cid", 
							"type": "long"
						}, 
						{
							"name": "access", 
							"type": "string"
						}, 
						{
							"name": "title", 
							"type": "text"
						},	
						{
							"name": "content", 
							"type": "text"
						},
						{
							"name": "hits", 
							"type": "long"
						}, 
						{
							"name": "createtime", 
							"type": "date"
						}
                    ]
				  }
				}
            }
        ]
    }
}
```


### 正确使用
---
如果你觉得自己编写脚本或者编译模块比较费时费力，那么可以直接下载以下的安装包进行文件的替换
``` sh
wget https://www.swiftadmin.net/tools/es-plugin-write.zip
```
分别包含，datax.py job.json job1.json文件，以及elasticsearchwriter模块（修改版），编译环境为JDK1.8+
::: tip 提示
 修改datax.py支持Python3版本，<br/>
 修改elasticsearchwriter模块设置type:id的时候，保留字段<br/>
 修改elasticsearchwriter模块当索引类型为TEXT的时候，默认去掉所有HTML标签<br/>
:::

至于DATAX更多的使用技巧，请翻阅官方的社区或者网上的资料，这东西，开源的，居然连个像样的文档都没得！

## 使用建议
::: warning 友情提示

> <font color="red">XunSearch 迅搜全文搜索引擎</font>

优点： 占用内存小，轻量级易维护。<br/>
缺点： 不支持in/not in 等条件检索！<br/>
> <font color="red">ElasticSearch 迅搜全文搜索引擎</font>

优点： 开箱即用，轻松支持PB级数据检索<br/>
缺点： 耗内存，掌握ES付出的学习成本比XS高<br/>
* 如果你的数据量在千万级以下，并且对搜索的要求不高，那么强烈建议你使用`XunSearch`迅搜全文检索，基本上几百万的数据检索，都在毫秒级返回数据。
* 如果你的数据量在千万级以上，那么建议你付出一些学习成本和运营服务器的费用，使用安全稳定，性能强大的`ElasticSearch`去做检索！生产环境首选！
:::

## 写在最后

* 看自己的数据量，来确定是否开启全文检索服务，一般建议数据量在百万级以上，再去开启全文检索。
* 在正确配置完XS/ES服务器后，请在基础配置中，将全文检索服务打开，并选择您所需要的检索服务的类型。
* 在服务正常运行后，数据在后台的增删改查，会自动同步更新到相关的索引服务中，我们建议不同的模块创建不同的索引库进行维护
* 如果你有更好的建议和BUG提交，请前往GITEE或者GITHUB提交您的ISSUE，希望我们共同的维护，可以将此项目变得更加的已用和强大！

::: tip 价值万元的建议
如果你偶尔做做流量站的SEO优化，那么建议你，将平时经常使用的字段增加到索引中，直接从索引中读取数据就行了，<br/>
阿里云2H2G的云服务器，搭载200万的文章数据，基本上毫秒级访问，带宽1M。对待用户的各种访问操作体验度很不错！
:::