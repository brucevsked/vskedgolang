# 星辰英语本

## 安装GF CLI 工具
$ go install github.com/gogf/gf/cmd/gf/v2@latest

## 检查版本
$ gf version

## 初始化项目
$ gf init star
initializing...
initialization done!
you can now run "cd star && gf run main.go" to start your journey, enjoy!

$ cd star && gf run main.go
build: .\main.go
go build -o .\main.exe  .\main.go
.\main.exe 
build running pid: 13628
2024-11-06 16:45:46.015 [INFO] pid[13628]: http server started listening on [:8000]
2024-11-06 16:45:46.015 [INFO] {4c9b7c33a654051860769a5fdef82a84} swagger ui is serving at address: http://127.0.0.1:8000/swagger/
2024-11-06 16:45:46.015 [INFO] {4c9b7c33a654051860769a5fdef82a84} openapi specification is serving at address: http://127.0.0.1:8000/api.json

  ADDRESS | METHOD |   ROUTE    |                        HANDLER                        |           MIDDLEWARE
----------|--------|------------|-------------------------------------------------------|----------------------------------
  :8000   | ALL    | /api.json  | github.com/gogf/gf/v2/net/ghttp.(*Server).openapiSpec |
----------|--------|------------|-------------------------------------------------------|----------------------------------
  :8000   | GET    | /hello     | star/internal/controller/hello.(*ControllerV1).Hello  | ghttp.MiddlewareHandlerResponse
----------|--------|------------|-------------------------------------------------------|----------------------------------
  :8000   | ALL    | /swagger/* | github.com/gogf/gf/v2/net/ghttp.(*Server).swaggerUI   | HOOK_BEFORE_SERVE
----------|--------|------------|-------------------------------------------------------|----------------------------------

连接试下效果
http://127.0.0.1:8000/hello

先按两次ctrl+c 停止项目，再开始升级  
## 升级项目
$ gf up

项目初始化后，我们来看一下项目的目录结构：

目录/文件名称	说明	描述
api	对外接口	对外提供服务的输入/输出数据结构定义。考虑到版本管理需要，往往以 api/xxx/v1... 存在。
hack	工具脚本	存放项目开发工具、脚本等内容。例如，CLI 工具的配置，各种 shell/bat 脚本等文件。
internal	内部逻辑	业务逻辑存放目录。通过 Golang internal 特性对外部隐藏可见性。
cmd	入口指令	命令行管理目录。可以管理维护多个命令行。
consts	常量定义	项目所有常量定义。
controller	接口处理	接收/解析用户输入参数的入口/接口层。
dao	数据访问	数据访问对象，这是一层抽象对象，用于和底层数据库交互，仅包含最基础的 CRUD 方法。
logic	业务封装	业务逻辑封装管理，特定的业务逻辑实现和封装。往往是项目中最复杂的部分。
model	结构模型	数据结构管理模块，管理数据实体对象，以及输入与输出数据结构定义。
do	领域对象	用于 dao 数据操作中业务模型与实例模型转换，由工具维护，用户不能修改。
entity	数据模型	数据模型是模型与数据集合的一对一关系，由工具维护，用户不能修改。
service	业务接口	用于业务模块解耦的接口定义层。具体的接口实现在 logic 中进行注入。
manifest	交付清单	包含程序编译、部署、运行、配置的文件。常见内容如下：
config	配置管理	配置文件存放目录。
docker	镜像文件	Docker 镜像相关依赖文件，脚本文件等等。
deploy	部署文件	部署相关的文件。默认提供了 Kubernetes 集群化部署的 Yaml 模板，通过 kustomize 管理。
protobuf	协议文件	GRPC 协议时使用的 protobuf 协议定义文件，协议文件编译后生成 go 文件到 api 目录。
resource	静态资源	静态资源文件。这些文件往往可以通过资源打包/镜像编译的形式注入到发布文件中。
go.mod	依赖管理	使用 Go Module 包管理的依赖描述文件。
main.go	入口文件	程序入口文件。
看起来似乎一头雾水啊，不必担心，重要的目录都会在后面陆续用到。

然后我们把初始的示例文件全部删除，留下一个空白的环境，用作后续开发。先按CTRL+C终止项目运行，删除如下目录内的所有文件：

api/*
internal/controller/*

删除后我们编辑一个cmd文件，去掉不必要的代码
internal/cmd/cmd.go

package cmd

import (
    "context"

    "github.com/gogf/gf/v2/frame/g"
    "github.com/gogf/gf/v2/net/ghttp"
    "github.com/gogf/gf/v2/os/gcmd"
)

var (
    Main = gcmd.Command{
        Name:  "main",
        Usage: "main",
        Brief: "start http server",
        Func: func(ctx context.Context, parser *gcmd.Parser) (err error) {
            s := g.Server()
            s.Group("/", func(group *ghttp.RouterGroup) {
                group.Middleware(ghttp.MiddlewareHandlerResponse)
            })
            s.Run()
            return nil
        },
    }
)

## 先提交一次代码吧 

# 用户注册

## 安装MySQL驱动
$ go get -u github.com/gogf/gf/contrib/drivers/mysql/v2

## 全局引入驱动
main.go

package main

import (
    _ "github.com/gogf/gf/contrib/drivers/mysql/v2"
    ...
)

func main() {
    cmd.Main.Run(gctx.GetInitCtx())
}

## 检查驱动
manifest/config/config.yaml
server:
    address: ":8000"         # 服务监听端口
    openapiPath: "/api.json" # OpenAPI接口文档地址
    swaggerPath: "/swagger"  # 内置SwaggerUI展示地址

database:
  default:
    link:   "mysql:starenglishbook:starenglishbook@tcp(127.0.0.1:3306)/starenglishbook?loc=Local"
    debug:  true

## 修改主函数，在程序运行前检查数据库是否正常连接
main.go
package main

···

func main() {
    var err error

    // 检查数据库是否能连接
    err = connDb()
    if err != nil {
        panic(err)
    }

    cmd.Main.Run(gctx.GetInitCtx())
}

// connDb 检查数据库连接是否正常
func connDb() error {
    err := g.DB().PingMaster()
    if err != nil {
        return errors.New("连接到数据库失败")
    }
    return nil
}

## 运行一下主项目看看效果
运行项目，如果没有报错，说明数据库驱动安装成功。
$ gf run main.go
build: .\main.go
go build -o .\main.exe  .\main.go
.\main.exe 
build running pid: 24612
2024-11-07 16:42:51.197 [INFO] {f89117371ba305188476a74abc958a23} swagger ui is serving at address: http://127.0.0.1:8000/swagger/
2024-11-07 16:42:51.197 [INFO] pid[24612]: http server started listening on [:8000]
2024-11-07 16:42:51.197 [INFO] {f89117371ba305188476a74abc958a23} openapi specification is serving at address: http://127.0.0.1:8000/api.json

  ADDRESS | METHOD |   ROUTE    |                        HANDLER                        |    MIDDLEWARE
----------|--------|------------|-------------------------------------------------------|--------------------
  :8000   | ALL    | /api.json  | github.com/gogf/gf/v2/net/ghttp.(*Server).openapiSpec |
----------|--------|------------|-------------------------------------------------------|--------------------
  :8000   | ALL    | /swagger/* | github.com/gogf/gf/v2/net/ghttp.(*Server).swaggerUI   | HOOK_BEFORE_SERVE
----------|--------|------------|-------------------------------------------------------|--------------------

gf run main.go是GF CLI提供的程序运行命令，当开发者修改了项目中的 go 文件时，该命令将停止原有程序，自动编译并运行当前程序。可用作替代go run main.go。

## 建立数据表
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password CHAR(32) NOT NULL,
  email VARCHAR(100),
  created_at DATETIME,
  updated_at DATETIME
);

字段名	类型	解释
id	INT UNSIGNED	主键，自动递增，唯一标识用户
username	VARCHAR(50)	用户名，不允许为空
password	CHAR(32)	用户密码hash 值，固定长度为32个字符 ，不允许为空，
email	VARCHAR(100)	用户的电子邮件地址，可以为空
created_at	DATETIME	创建时间
updated_at	DATETIME	记录最后更新时间

生成数据模型
修改工具配置文件：
hack/config.yaml
gfcli:
  gen:
    dao:
      - link: "mysql:root:12345678@tcp(127.0.0.1:3306)/star"
hack/config.yaml 与 manifest/config/config.yaml 两个配置文件不要混淆，前者是用于开发工具的配置文件，后者是用于业务配置的文件。

执行GF-CLI命令生成数据模型：
$ gf gen dao

执行成功后，会在model层和dao层生成四个文件：
internal/model/do/users.go
internal/model/entity/users.go
internal/dao/internal/users.go
internal/dao/users.go

model层用作GoFrame管理数据结构，与数据表一一对应，不允许用户修改。model/do/users.go用作数据写入对象，采用泛型设计，方便数据入库；model/entity/users.go用作数据读取对象，类型与数据表保持一致。

dao层管理数据访问对象，GoFrame ORM通过它实现对数据表的增删改查。dao/internal/users.go保存内部对象实现，不允许用户修改，也不对外暴露。dao/users.go实例化数据访问对象并对外暴露，用户可以在这里添加自定义的方法。



准备好数据模型后，就可以使用我们的"三板斧"法则开发用户接口了。

## 添加API
api/users/v1/users.go

package v1

import "github.com/gogf/gf/v2/frame/g"

type RegisterReq struct {
    g.Meta   `path:"users/register" method:"post"`
    Username string `json:"username"`
    Password string `json:"password"`
    Email    string `json:"email"`
}

type RegisterRes struct {
}

为了更好的维护接口，通常会在接口地址的前面加上版本号。GoFrame推荐使用多级目录管理版本，这个接口的版本号是v1。

RegisterReq和RegisterRes分别定义HTTP的请求对象和响应对象。g.Meta内嵌到请求结构体中，并通过Go Tag方式来定义一般的接口属性。这段代码意味着我们新增了一个用户注册的接口，接口地址为/users/register，请求方式为POST，并且拥有三个请求参数：Username、Password、Email。

执行命令生成Api对应的Controller：

$ gf gen ctrl
generated: D:\project\star\api\users\users.go
generated: internal\controller\users\users.go
generated: internal\controller\users\users_new.go
generated: internal\controller\users\users_v1_register.go
done!

这里生成的四个文件，我们只需要关注users_v1_register.go即可，它用作接收HTTP请求，并调用Logic完成业务流程。

如果您已经安装了GoFrame Helper插件，会自动执行gf gen ctrl命令。也可以使用官网提供自动生成方式：教程配置。

编写Logic
Logic 是业务逻辑层，存放在internal/logic下，供Controller调用从而实现具体的业务逻辑。

定义一个Users对象，并新建一个New函数用作实例化它：

internal/logic/users/users.go

package users  
  
type Users struct {  
}

func New() *Users {  
    return &Users{}  
}

编写注册方法：

internal/logic/users/users_register.go

package users

import (
    "context"

    "star/internal/dao"
    "star/internal/model/do"
)

func (u *Users) Register(ctx context.Context, username, password, email string) error {
    _, err := dao.Users.Ctx(ctx).Data(do.Users{
        Username: username,
        Password: password,
        Email:    email,
    }).Insert()
    if err != nil {
        return err
    }
    return nil
}

dao.Users是前面生成的数据访问对象，通过它与数据库交互。do.Users是生成的数据模型，它用作数据入库，还有一个类似的数据模型entity.Users用作数据出库。

Controller调用Logic

Controller 层负责接收 Req 请求对象后调用一个或多个Logic完成业务逻辑，一些简单的逻辑也可以直接放在Controller中处理。处理完成后的结果封装在约定的 Res 数据结构中返回。这里的Res数据结构为空，返回nil即可。

将Users对象封装到控制器中，方便后续调用。

internal/controller/users/users_new.go
package users

import (
	"star/api/users"
	userLogic "star/internal/logic/users"
)

type ControllerV1 struct {
	users *userLogic.Users
}

func NewV1() users.IUsersV1 {
	return &ControllerV1{}
}


internal/controller/users/users_v1_register.go

package users

import (
    "context"

    "star/internal/logic/users"

    "star/api/users/v1"
)

func (c *ControllerV1) Register(ctx context.Context, req *v1.RegisterReq) (res *v1.RegisterRes, err error) {
    err = c.users.Register(ctx, req.Username, req.Password, req.Email)
    return nil, err
}

注册控制器
所有的控制器都必须要在cmd中注册才能生效。cmd 层负责引导程序启动，显著的工作是初始化逻辑、注册路由对象、启动 server 监听、阻塞运行程序直至 server 退出。

internal/cmd/cmd.go

package cmd

import (
	"context"
	"star/internal/controller/users"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/gogf/gf/v2/os/gcmd"
)

var (
	Main = gcmd.Command{
		Name:  "main",
		Usage: "main",
		Brief: "start http server",
		Func: func(ctx context.Context, parser *gcmd.Parser) (err error) {
			s := g.Server()
			s.Group("/", func(group *ghttp.RouterGroup) {
				group.Middleware(ghttp.MiddlewareHandlerResponse)
				group.Group("/v1", func(group *ghttp.RouterGroup) {
					group.Bind(
						users.NewV1(),
					)
				})
			})
			s.Run()
			return nil
		},
	}
)


group.Group 是框架提供的分组路由注册方式，也是框架推荐的注册方式。我们在前面加上v1对应api目录，方便接口版本管理。

运行项目
$ gf run main.go
build: .\main.go
go build -o .\main.exe  .\main.go
.\main.exe 
build running pid: 8648
2024-11-08 10:36:48.013 [INFO] pid[8648]: http server started listening on [:8000]
2024-11-08 10:36:48.013 [INFO] {e05c16b565dd0518360ebe639e1c623d} swagger ui is serving at address: http://127.0.0.1:8000/swagger/
2024-11-08 10:36:48.014 [INFO] {e05c16b565dd0518360ebe639e1c623d} openapi specification is serving at address: http://127.0.0.1:8000/api.json

  ADDRESS | METHOD |       ROUTE        |                         HANDLER                         |           MIDDLEWARE
----------|--------|--------------------|---------------------------------------------------------|----------------------------------
  :8000   | ALL    | /api.json          | github.com/gogf/gf/v2/net/ghttp.(*Server).openapiSpec   |
----------|--------|--------------------|---------------------------------------------------------|----------------------------------
  :8000   | ALL    | /swagger/*         | github.com/gogf/gf/v2/net/ghttp.(*Server).swaggerUI     | HOOK_BEFORE_SERVE
----------|--------|--------------------|---------------------------------------------------------|----------------------------------
  :8000   | POST   | /v1/users/register | star/internal/controller/users.(*ControllerV1).Register | ghttp.MiddlewareHandlerResponse
----------|--------|--------------------|---------------------------------------------------------|----------------------------------

运行结果中打印出了三个接口地址。/swagger 和 /api.json是框架生成的接口文档地址，我们会在2.5 - 接口文档详细的说明它。另外一个地址/v1/users/register便是我们开发出来的用户注册接口。发起一个POST请求来测试它。

$ curl -X POST http://127.0.0.1:8000/v1/users/register -H "Content-Type: application/json" -d "{\"username\":\"oldme\", \"password\":\"123456\", \"email\":\"tyyn1022@gmail.com\"}"

{
    "code":0,
    "message":"",
    "data":null
}

code为0代表成功，去数据库查看是否插入了一条数据：

SELECT * FROM users;

有数据了，开发完一个功能记得再提交下代码。是提交到分支上呀。

## 业务优化
当前注册流程还存在几个显著的问题需要优化：

接口参数没有校验，即使全部留空或随意填写也能入库成功。为此，用户名、密码、邮箱都应该必传，且需要有一定的安全验证。例如，密码应该在6-12位之间，邮箱应该是xx@xx.xx格式；
禁止注册相同的用户；
密码不应该明文入库，应加密后入库；
logic/Register函数参数过多，一来显示不优雅，二来不利于维护，应该将用户信息定义到一个结构体中，将其作为函数入参。

参数校检
GoFrame内置了强大的接口参数校检功能，只需要在g.Meta的tag上加上v即可启用。

api/users/v1/users.go
package v1  
  
import "github.com/gogf/gf/v2/frame/g"  
  
type RegisterReq struct {  
    g.Meta   `path:"users/register" method:"post"`  
    Username string `json:"username" v:"required|length:3,12"`  
    Password string `json:"password" v:"required|length:6,16"`  
    Email    string `json:"email" v:"required|email"`  
}  
  
type RegisterRes struct {  
}

多个验证规则使用|隔开，required表示此字段必填，length表示位数在3-12之间，email表示只接受合法的邮箱地址。所有可用的验证规则可在开发手册中查阅。

发起一个空用户名请求测试：
$ curl -X POST http://127.0.0.1:8000/v1/users/register -H "Content-Type: application/json" -d "{\"password\":\"123456\", \"email\":\"tyyn1022@gmail.com\"}"

{
    "code":51,
    "message":"The Username field is required",
    "data":null
}

The Username field is required提示我们用户名不能为空。

如果您对英文提示不满意，还可以使用框架提供的i18n组件改成中文提示。

参数校检i18n
从Github下载文件并且存放到manifest/i18n目录，直接从下文复制也行。

manifest/i18n/zh-CN/validation.toml

"gf.gvalid.rule.required"             = "{field}字段不能为空"
"gf.gvalid.rule.required-if"          = "{field}字段不能为空"
"gf.gvalid.rule.required-unless"      = "{field}字段不能为空"
"gf.gvalid.rule.required-with"        = "{field}字段不能为空"
"gf.gvalid.rule.required-with-all"    = "{field}字段不能为空"
"gf.gvalid.rule.required-without"     = "{field}字段不能为空"
"gf.gvalid.rule.required-without-all" = "{field}字段不能为空"
"gf.gvalid.rule.date"                 = "{field}字段值`{value}`日期格式不满足Y-m-d格式，例如: 2001-02-03"
"gf.gvalid.rule.datetime"             = "{field}字段值`{value}`日期格式不满足Y-m-d H:i:s格式，例如: 2001-02-03 12:00:00"
"gf.gvalid.rule.date-format"          = "{field}字段值`{value}`日期格式不满足{format}"
"gf.gvalid.rule.email"                = "{field}字段值`{value}`邮箱地址格式不正确"
"gf.gvalid.rule.phone"                = "{field}字段值`{value}`手机号码格式不正确"
"gf.gvalid.rule.phone-loose"          = "{field}字段值`{value}`手机号码格式不正确"
"gf.gvalid.rule.telephone"            = "{field}字段值`{value}`电话号码格式不正确"
"gf.gvalid.rule.passport"             = "{field}字段值`{value}`账号格式不合法，必需以字母开头，只能包含字母、数字和下划线，长度在6~18之间"
"gf.gvalid.rule.password"             = "{field}字段值`{value}`密码格式不合法，密码格式为任意6-18位的可见字符"
"gf.gvalid.rule.password2"            = "{field}字段值`{value}`密码格式不合法，密码格式为任意6-18位的可见字符，必须包含大小写字母和数字"
"gf.gvalid.rule.password3"            = "{field}字段值`{value}`密码格式不合法，密码格式为任意6-18位的可见字符，必须包含大小写字母、数字和特殊字符"
"gf.gvalid.rule.postcode"             = "{field}字段值`{value}`邮政编码不正确"
"gf.gvalid.rule.resident-id"          = "{field}字段值`{value}`身份证号码格式不正确"
"gf.gvalid.rule.bank-card"            = "{field}字段值`{value}`银行卡号格式不正确"
"gf.gvalid.rule.qq"                   = "{field}字段值`{value}`QQ号码格式不正确"
"gf.gvalid.rule.ip"                   = "{field}字段值`{value}`IP地址格式不正确"
"gf.gvalid.rule.ipv4"                 = "{field}字段值`{value}`IPv4地址格式不正确"
"gf.gvalid.rule.ipv6"                 = "{field}字段值`{value}`IPv6地址格式不正确"
"gf.gvalid.rule.mac"                  = "{field}字段值`{value}`MAC地址格式不正确"
"gf.gvalid.rule.url"                  = "{field}字段值`{value}`URL地址格式不正确"
"gf.gvalid.rule.domain"               = "{field}字段值`{value}`域名格式不正确"
"gf.gvalid.rule.length"               = "{field}字段值`{value}`字段长度应当为{min}到{max}个字符"
"gf.gvalid.rule.min-length"           = "{field}字段值`{value}`字段最小长度应当为{min}"
"gf.gvalid.rule.max-length"           = "{field}字段值`{value}`字段最大长度应当为{max}"
"gf.gvalid.rule.size"                 = "{field}字段值`{value}`字段长度必须应当为{size}"
"gf.gvalid.rule.between"              = "{field}字段值`{value}`字段大小应当为{min}到{max}"
"gf.gvalid.rule.min"                  = "{field}字段值`{value}`字段最小值应当为{min}"
"gf.gvalid.rule.max"                  = "{field}字段值`{value}`字段最大值应当为{max}"
"gf.gvalid.rule.json"                 = "{field}字段值`{value}`字段应当为JSON格式"
"gf.gvalid.rule.xml"                  = "{field}字段值`{value}`字段应当为XML格式"
"gf.gvalid.rule.array"                = "{field}字段值`{value}`字段应当为数组"
"gf.gvalid.rule.integer"              = "{field}字段值`{value}`字段应当为整数"
"gf.gvalid.rule.float"                = "{field}字段值`{value}`字段应当为浮点数"
"gf.gvalid.rule.boolean"              = "{field}字段值`{value}`字段应当为布尔值"
"gf.gvalid.rule.same"                 = "{field}字段值`{value}`字段值必须和{field}相同"
"gf.gvalid.rule.different"            = "{field}字段值`{value}`字段值不能与{field}相同"
"gf.gvalid.rule.in"                   = "{field}字段值`{value}`字段值应当满足取值范围:{pattern}"
"gf.gvalid.rule.not-in"               = "{field}字段值`{value}`字段值不应当满足取值范围:{pattern}"
"gf.gvalid.rule.regex"                = "{field}字段值`{value}`字段值不满足规则:{pattern}"
"gf.gvalid.rule.__default__"          = "{field}字段值`{value}`字段值不合法"
"CustomMessage"                       = "自定义错误"
"project id must between {min}, {max}"  = "项目ID必须大于等于{min}并且要小于等于{max}"

修改主函数，启用i18n：

main.go
package main  
  
···

func main() {  
    var err error  
  
    // 全局设置i18n  
    g.I18n().SetLanguage("zh-CN")  
  
    // 检查数据库是否能连接  
    err = connDb()  
    if err != nil {  
       panic(err)  
    }  
  
    cmd.Main.Run(gctx.GetInitCtx())  
}  

···

重启项目，ctrl+c 然后再运行
gf run main.go
再次发起请求：
$ curl -X POST http://127.0.0.1:8000/v1/users/register -H "Content-Type: application/json" -d "{\"password\":\"123456\", \"email\":\"tyyn1022@gmail.com\"}"

{
    "code":51,
    "message":"Username字段不能为空",
    "data":null
}

可以看到message已经变成中文提示了。


禁止重复用户名

用户名是登录的重要依据，如果碰巧系统中有两个同名用户，则会出现重大的逻辑混乱。所以我们需要在数据入库前查询该用户是否存在，如果存在，则返回错误信息，提示用户已经存在。

internal/logic/users/users_register.go
package users  
  
...
  
func (u *Users) Register(ctx context.Context, username, password, email string) error {  
    if err := u.checkUser(ctx, username); err != nil {  
       return err  
    }  
  
    _, err := dao.Users.Ctx(ctx).Data(do.Users{  
       Username: username,  
       Password: password,  
       Email:    email,  
    }).Insert()  
    if err != nil {  
       return err  
    }  
    return nil  
}  
  
func (u *Users) checkUser(ctx context.Context, username string) error {  
    count, err := dao.Users.Ctx(ctx).Where("username", username).Count()  
    if err != nil {  
       return err  
    }  
    if count > 0 {  
       return gerror.New("用户已存在")  
    }  
    return nil  
}

发起请求测试结果：

$ curl -X POST http://127.0.0.1:8000/v1/users/register -H "Content-Type: application/json" -d "{\"username\":\"oldme\", \"password\":\"123456\", \"email\":\"tyyn1022@gmail.com\"}"

{
    "code":50,
    "message":"用户已存在",
    "data":null
}

只有代码检测还不够安全，我们在数据表中加上唯一索引，强制限制用户唯一。

ALTER TABLE users ADD UNIQUE (username);

密码加密
密码明文保存是一种非常不安全的行为，通常的做法是对其hash计算后存入数据库，例如md5、SHA-1等。

新增一个方法encryptPassword实现密码加密功能。

internal/logic/users/users.go

package users  
  
import "github.com/gogf/gf/v2/crypto/gmd5"  
  
...

func (u *Users) encryptPassword(password string) string {  
    return gmd5.MustEncryptString(password)  
}

gmd5组件帮助我们快速实现md5加密功能。编写注册逻辑代码，引入密码加密。

internal/logic/users/users_register.go

package users  
  
...
  
func (u *Users) Register(ctx context.Context, username, password, email string) error {  
    ...
  
    _, err := dao.Users.Ctx(ctx).Data(do.Users{  
       Username: username,  
       Password: u.encryptPassword(password),  
       Email:    email,  
    }).Insert()  
    if err != nil {  
       return err  
    }  
    return nil  
}  

...

删除原本的用户：（如果想让删除用户id重置需要用  TRUNCATE TABLE users;来删除用户数据）
SELECT * FROM users;
DELETE FROM users WHERE id = 1;
SELECT * FROM users;
重新请求接口查看密码是否成功加密：

curl -X POST http://127.0.0.1:8000/v1/users/register -H "Content-Type: application/json" -d "{\"username\":\"oldme\", \"password\":\"123456\", \"email\":\"tyyn1022@gmail.com\"}"

结果：

ID	Username	Password	Email	Created_At	Updated_At
1	oldme	e10adc3949ba59abbe56e057f20f883e	tyyn1022@gmail.com	2024-11-08 10:36:48	2024-11-08 10:36:48

Register 函数优化
自定义一个数据模型，用作Logic层的入参。

internal/logic/users/users_register.go

package users  
  
import (
    "star/internal/model"
    ...
)

func (u *Users) Register(ctx context.Context, in RegisterInput) error {  
    if err := u.checkUser(ctx, in.Username); err != nil {  
       return err  
    }  
  
    _, err := dao.Users.Ctx(ctx).Data(do.Users{  
       Username: in.Username,  
       Password: u.encryptPassword(in.Password),  
       Email:    in.Email,  
    }).Insert()  
    if err != nil {  
       return err  
    }  
    return nil  
}

...


更改Controller层，将RegisterInput传入。

internal/controller/users/users_v1_register.go

package users

import (
	"context"

	v1 "star/api/users/v1"
	"star/internal/logic/users"
)

func (c *ControllerV1) Register(ctx context.Context, req *v1.RegisterReq) (res *v1.RegisterRes, err error) {
	err = c.users.Register(ctx, users.RegisterInput{
		Username: req.Username,
		Password: req.Password,
		Email:    req.Email,
	})
	return nil, err
}

编写完成的接口交给前端调用时，需要为他们准备好一份接口文档。幸运的是，GoFrame已经内置自动生成接口文档功能，节省了我们大量的时间。只需要在编写api时携带一些额外的tag，即可生成优美的文档。

api/users/v1/users.go
package v1  
  
import "github.com/gogf/gf/v2/frame/g"  
  
type RegisterReq struct {  
    g.Meta   `path:"users/register" method:"post" sm:"注册" tags:"用户"`  
    Username string `json:"username" v:"required|length:3,12" dc:"用户名"`  
    Password string `json:"password" v:"required|length:6,16" dc:"密码"`  
    Email    string `json:"email" v:"required|email" dc:"邮箱"`  
}  
  
type RegisterRes struct {  
}

在浏览器中打开 
http://127.0.0.1:8000/swagger

另外一个地址
http://127.0.0.1:8000/api.json
提供了Json格式的接口文档，可以导入到各类Api工具中使用。

除了sm、tags和dc标签外，GoFrame还提供了如下标签：

常见OpenAPIv3标签	说明	备注
path	结合注册时的前缀共同构成接口URI路径	用于 g.Meta 标识接口元数据
tags	接口所属的标签，用于接口分类	用于 g.Meta 标识接口元数据
method	接口的请求方式： GET/PUT/POST/DELETE...(不区分大小写)	用于 g.Meta 标识接口元数据
deprecated	标记该接口废弃	用于 g.Meta 标识接口元数据
summary	接口/参数概要描述	缩写 sm
description	接口/参数详细描述	缩写 dc
in	参数的提交方式	header/path/query/cookie
default	参数的默认值	缩写 d
mime	接口的 MIME 类型，例如 multipart/form-data 一般是全局设置，默认为 application/json。	用于 g.Meta 标识接口元数据
type	参数的类型，一般不需要设置，特殊参数需要手动设置，例如 file	仅用于参数属性

## 总结
在本章节中，我们使用GoFrame完成了一个注册接口。初步接触了GoFrame并学会了以下内容：

安装数据库驱动；
使用gf gen dao生成数据模型；
通过dao调用GoFrame ORM与数据库交互；
编写api文件并使用gf gen ctrl生成控制器；
Controller层调用Logic层完成业务逻辑；
接口参数校检与i18n。
提交吧

# 会话管理
在本章中，我们需要完成用户的会话管理功能：

登录；
获取用户信息。
JWT 简介
HTTP 是一种无状态协议，这意味着每次请求都是独立的，没有上下文关系。这就需要一种机制来保存用户的状态信息，Cookie 就是其中一种解决方案。Cookie 是存储在用户浏览器中的小块数据，可以在后续请求中发送给服务器，用于保持会话状态。然而，Cookie 也有一些限制，例如跨域问题和安全性问题。相比之下，JWT 是一种更现代的解决方案，可以通过 HTTP 头部传递，无需依赖 Cookie，且具有更好的跨域支持和安全性。

JWT全名Json Web Token，其看起来是一串无序的字符串。由三部分组成：头部（Header）、负载（Payload）和签名（Signature）。

在前后端分离的项目中，用户登录后，服务端生成JWT并返回，客户端自行保存它，例如浏览器本地储存Local Storage。在后续的请求中，通常在Header头的Authorization字段中携带它，以完成用户身份认证。
安装 golang-jwt
生成验证JWT需要复杂的加密解密的逻辑，自己编写需费一番手脚。所幸的是，前人已经造好了轮子，直接安装调用即可。

$ go get -u github.com/golang-jwt/jwt/v5

登录接口收到用户名和密码后，与数据库中的信息做比对，如果正确则生成Token返回，否则提示”用户名或密码错误“。

同样遵循三板斧开发原则：编写Api生成Controller，编写核心逻辑Logic，Controller调起Logic。
添加Api
api/users/v1/users.go
...
  
type LoginReq struct {  
    g.Meta   `path:"users/login" method:"post" sm:"登录" tags:"用户"`  
    Username string `json:"username" v:"required|length:3,12"`  
    Password string `json:"password" v:"required|length:6,16"`  
}  
  
type LoginRes struct {  
    Token string `json:"token" dc:"在需要鉴权的接口中header加入Authorization: token"`
}
别忘记执行gf gen ctrl哦！每次变更Api都需要执行它，后文不再重复提示。

$ gf gen ctrl

编写Logic
登录逻辑的的难点在于生成Token。准备好一个随机字符串JwtKey用作签名。

internal/consts/consts.go
package consts  
  
const (  
    JwtKey = "xiujiezhiliang888zhen666tailihai"  
)

编写核心逻辑，先根据用户名进行Where查询，获取到数据后，将密码再次加密，如果和数据库中的密文一致则说明是合法用户，生成Token返回。

internal/logic/users/users_account.go
package users  
  
import (  
    "context"  
    "errors"
    "time"  
    
    "github.com/golang-jwt/jwt/v5"
    
    "star/internal/dao"    
    "star/internal/model/entity"    
    "star/utility"
)
  
type jwtClaims struct {  
    Id       uint  
    Username string  
    jwt.RegisteredClaims  
}  
  
func (u *Users) Login(ctx context.Context, username, password string) (tokenString string, err error) {  
    var user entity.Users  
    err = dao.Users.Ctx(ctx).Where("username", username).Scan(&user)  
    if err != nil {  
       return "", gerror.New("用户名或密码错误")  
    }  
  
    if user.Id == 0 {  
       return "", gerror.New("用户不存在")  
    }  
  
    // 将密码加密后与数据库中的密码进行比对  
    if user.Password != u.encryptPassword(password) {  
       return "", gerror.New("用户名或密码错误")  
    }  
  
    // 生成token  
    uc := &jwtClaims{  
       Id:       user.Id,  
       Username: user.Username,  
       RegisteredClaims: jwt.RegisteredClaims{  
          ExpiresAt: jwt.NewNumericDate(time.Now().Add(6 * time.Hour)),  
       },  
    }  
    token := jwt.NewWithClaims(jwt.SigningMethodHS256, uc)
    return token.SignedString([]byte(consts.JwtKey))
}

从上面的代码可以看到，我们需要声明一个结构体userClaims保存签名信息，这里保存了Id和Username并设置了Token有效期为 6 个小时。最后的声明对象还需要调用SignedString方法传入JwtKey生成签名。

Controller调用Logic
internal/controller/users/users_v1_login.go
package users

import (
	"context"

	v1 "star/api/users/v1"
)

func (c *ControllerV1) Login(ctx context.Context, req *v1.LoginReq) (res *v1.LoginRes, err error) {
	token, err := c.users.Login(ctx, req.Username, req.Password)
	if err != nil {
		return
	}
	return &v1.LoginRes{Token: token}, nil
}

接口测试
如果项目没启动，先启动项目哟
gf run main.go

$ curl -X POST http://127.0.0.1:8000/v1/users/login -H "Content-Type: application/json" -d "{\"username\":\"oldme\", \"password\":\"123456\"}"

{
    "code":0,
    "message":"",
    "data":{
        "token":"eyJhbGciOi...ZY_ATzOU"
    }
}

用户信息是一个敏感的接口，它必须要保证用户登录之后才能访问。同样的，用户编辑单词库相关的接口也需要权限认证。我们不可能在每个需要认证的接口前都编写同样的代码用以权限认证。所以要编写一个中间件/拦截器来统一验证Token是否有效。

中间件/拦截器是处理 HTTP 请求和响应的函数或组件。它们通常用于在请求到达最终处理器之前或响应发送给客户端之前执行一些操作。

## Auth 中间件
GoFrame 提供了优雅的中间件请求控制方式， 该方式也是主流的 WebServer 提供的请求流程控制方式， 基于中间件设计可以为 WebServer 提供更灵活强大的插件机制。

internal/logic/middleware/auth.go
package middleware

import (
    "net/http"

    "star/internal/consts"

    "github.com/gogf/gf/v2/net/ghttp"
    "github.com/golang-jwt/jwt/v5"
)

func Auth(r *ghttp.Request) {
    var tokenString = r.Header.Get("Authorization")
    token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
        return []byte(consts.JwtKey), nil
    })
    if err != nil || !token.Valid {
        r.Response.WriteStatus(http.StatusForbidden)
        r.Exit()
    }
    r.Middleware.Next()
}

r.Middleware.Next() 这段代码是中间件的控制核心，放在函数的最后面表示它是一个前置中间件，代表请求前调用。放在最前面则是后置中间件，在请求后生效。

r.Header.Get("Authorization")从HTTP Header中获取Authorization字段，即获取前端传过来的Token。jwt.Parse 解析Token后再通过token.Valid验证是否有效，如果失效则返回 HTTP StatusForbidden 403 状态码，即权限不足，反之调用r.Middleware.Next()进入下一步。

编写好的中间件留用，等接口开发完成后统一注册到cmd中。接下来又是愉快的三板斧法则。

添加Api
api/account/v1/account.go
package v1  
  
import (  
    "github.com/gogf/gf/v2/frame/g"  
)  
  
type InfoReq struct {  
    g.Meta `path:"account/info" method:"get" sm:"获取信息" tags:"用户"`  
}  
  
type InfoRes struct {  
    Username  string      `json:"username" dc:"用户名"`  
    Email     string      `json:"email" dc:"邮箱"`  
    CreatedAt *gtime.Time `json:"created" dc:"创建时间"`  
    UpdatedAt *gtime.Time `json:"update" dc:"更新时间"`  
}

InfoRes结构体定义了四个响应数据，其中*gtime.Time数据类型是gtime组件提供的框架时间类型。

$ gf gen ctrl

编写Logic
internal/logic/users/users_account.go
package users  
  
import (  
    "context"  
    "errors"
    "time"  
    
    "github.com/gogf/gf/v2/frame/g"
    "github.com/golang-jwt/jwt/v5"
    "star/internal/dao"    
    "star/internal/model/entity"    
    "star/utility"
)

...

func (u *Users) Info(ctx context.Context) (user *entity.Users, err error) {  
    tokenString := g.RequestFromCtx(ctx).Request.Header.Get("Authorization")  
    tokenClaims, _ := jwt.ParseWithClaims(tokenString, &jwtClaims{}, func(token *jwt.Token) (interface{}, error) {  
       return  []byte(consts.JwtKey), nil  
    })  
  
    if claims, ok := tokenClaims.Claims.(*jwtClaims); ok && tokenClaims.Valid {  
       err = dao.Users.Ctx(ctx).Where("id", claims.Id).Scan(&user)  
    }  
    return  
}

在Logic中不能直接获取HTTP对象，需要使用g.RequestFromCtx(ctx).Request从上下文中获取。获取Token后解析出用户ID，调用Scan 方法将查询结果赋值给entity.Users结构体。

Scan方法是一个非常强大的方法，它会根据给定的参数类型自动识别并转换，是数据查询操作中的常客。
Controller调用Logic
同样将logic注册到控制器中。

internal/controller/account/account_new.go
...
  
package account  
  
import (  
    "star/api/account"  
    "star/internal/logic/users"
)  
  
type ControllerV1 struct {  
    users *users.Users  
}  
  
func NewV1() account.IAccountV1 {  
    return &ControllerV1{  
        users: users.New(),  
    }  
}

internal/controller/account/account_v1_info.go
package account  
  
import (  
    "context"  
  
    "star/api/account/v1"
)  
  
func (c *ControllerV1) Info(ctx context.Context, req *v1.InfoReq) (res *v1.InfoRes, err error) {  
    user, err := c.users.Info(ctx)  
    if err != nil {  
       return nil, err  
    }  
    return &v1.InfoRes{  
       Username:  user.Username,  
       Email:     user.Email,  
       CreatedAt: user.CreatedAt,  
       UpdatedAt: user.UpdatedAt,  
    }, nil  
}

注册新的控制器
使用group.Group新增一个路由分组，并使用group.Middleware注册Auth中间件，凡是在本组下的控制器在访问前都需要经过认证。

internal/cmd/cmd.go
package cmd  
  
import (  
    "context"  
  
    "github.com/gogf/gf/v2/frame/g"
    "github.com/gogf/gf/v2/net/ghttp"
    "github.com/gogf/gf/v2/os/gcmd"
    "star/internal/controller/account"
    "star/internal/controller/users"
    "star/internal/logic/middleware"
)  
  
var (  
    Main = gcmd.Command{  
       Name:  "main",  
       Usage: "main",  
       Brief: "start http server",  
       Func: func(ctx context.Context, parser *gcmd.Parser) (err error) {  
          s := g.Server()  
          s.Group("/", func(group *ghttp.RouterGroup) {  
             group.Middleware(ghttp.MiddlewareHandlerResponse)  
             group.Group("/v1", func(group *ghttp.RouterGroup) {  
                group.Bind(  
                   users.NewV1(),  
                )  
                group.Group("/", func(group *ghttp.RouterGroup) {  
                   group.Middleware(middleware.Auth)  
                   group.Bind(  
                      account.NewV1(),  
                   )  
                })  
             })  
          })  
          s.Run()  
          return nil  
       },  
    }  
)

接口测试
注意把Authorization换成自己的：
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MSwiVXNlcm5hbWUiOiJvbGRtZSIsImV4cCI6MTc2NDc2OTQ0MH0.6zMX7ezw4w2lJIFLEtESas_ptLx9nCNbMLf0xleWpTg

$ curl -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MSwiVXNlcm5hbWUiOiJvbGRtZSIsImV4cCI6MTc2NDc2OTQ0MH0.6zMX7ezw4w2lJIFLEtESas_ptLx9nCNbMLf0xleWpTg" http://127.0.0.1:8000/v1/account/info

{
    "code":0,
    "message":"",
    "data":{
        "username":"oldme",
        "email":"tyyn1022@gmail.com",
        "created":"2024-11-08 17:02:16",
        "update":"2024-11-08 17:02:16"
    }
}

## 会话管理总结
在本章节中，我们使用GoFrame完成了用户的会话管理，提供了登录和获取用户信息两大功能，加深了GoFrame的理解，并学会了以下内容：

声明用户结构体，生成Token；
Token解析出用户信息，提供获取用户信息接口;
中间件的基础使用，使用中间件完成用户权限认证；
分组路由注册中间件。
关于退出登录
为什么我们没有开发退出登录功能呢？这是因为JWT本质上是一个无状态的令牌，一旦签发，服务器不会存储它。这导致了在使用 JWT 时，退出登录不能像传统会话那样简单地在服务器端销毁会话。解决JWT退出登录的方案大致有两种，它们各有优劣：

黑名单机制：
当用户登出或 JWT 被撤销时，将该令牌添加到黑名单数据库中；
每次请求时，从请求头中提取 JWT，并检查它是否在黑名单中；
如果令牌在黑名单中，则拒绝请求；
其优势在于易于实现和维护，适用于大多数情况下；劣势在于需要存储所有被撤销的令牌，可能会导致存储空间增加。
白名单机制：
在用户登录时，将生成的 JWT 添加到白名单数据库中；
每次请求时，从请求头中提取 JWT，并检查它是否在白名单中；
如果令牌不在白名单中，则拒绝请求。
其优势在于更高的安全性，只有白名单中的令牌才能被接受，确保了更严格的访问控制。劣势在于复杂性增加，需要在用户登录时将令牌添加到白名单，并在合适的时候移除。
黑白名单数据一般会储存在非关系型数据库中，例如Redis。

记得提交并合并一下代码哟。

# 单词管理
在本章中，您将学习到程序员的核心技能——大名鼎鼎的增删查改操作，即Create（创建）、Read（读取）、Update（更新）、Delete（删除），简称为CRUD。这些操作构成了大多数应用程序的基础功能，通过它们我们将完成以下业务：

新增单词；
编辑单词；
单词分页列表；
单词详情；
删除单词。

RESTful简介
RESTful是一种基于REST(Representational State Transfer)架构风格的Web服务设计原则。它主要用于创建和访问Web资源，并具有以下特点：

资源：RESTful服务中的每一个对象都被视为资源，可以通过URI（统一资源标识符）进行访问。例如，/words可以表示单词资源；
HTTP动词：RESTful服务主要使用HTTP Method 来执行操作：
GET：读取资源
POST：创建资源
PUT：更新资源
PATCH：更新部分资源
DELETE：删除资源
表现层状态转移：客户端通过请求特定的URI来操作资源，服务器通过响应返回资源的表现形式（通常为JSON或XML）。
统一接口：通过标准化的接口设计，使得不同的系统能够互相通信。
通过这些原则，RESTful架构使得Web服务更加简洁、灵活和可扩展。以单词的CRUD为例。

操作	Method	URI	描述
创建 (Create)	POST	/words	创建一个新的单词
读取 (Read)	GET	/words	获取所有单词列表
读取 (Read)	GET	/words/{id}	根据ID获取单个单词
更新 (Update)	PUT	/words/{id}	更新指定ID的单词
更新 (Update)	PATCH	/words/{id}	更新指定ID的单词的部分字段
删除 (Delete)	DELETE	/words/{id}	删除指定ID的单词

建立数据表
建立一张新的数据表，用以保存单词，并且加上联合唯一索引uid, word，限制单个用户不能添加相同的单词。
CREATE TABLE words (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    uid INT UNSIGNED NOT NULL,
    word VARCHAR ( 255 ) NOT NULL,
    definition TEXT,
    example_sentence TEXT,
    chinese_translation VARCHAR ( 255 ),
    pronunciation VARCHAR ( 255 ),
    proficiency_level SMALLINT UNSIGNED,
    created_at DATETIME,
    updated_at DATETIME
);

ALTER TABLE words ADD UNIQUE (uid, word);

字段名	类型	解释
id	INT UNSIGNED	主键，自动递增，唯一标识单词
uid	INT UNSIGNED	用户id，标记该单词所属用户
word	VARCHAR(255)	单词，不允许为空
definition	TEXT	单词定义
example_sentence	TEXT	示例句子
chinese_translation	VARCHAR(255)	单词的中文翻译
pronunciation	VARCHAR(255)	单词的发音
proficiency_level	SMALLINT	单词掌握程度，1级最低，5级最高
created_at	DATETIME	记录创建时间
updated_at	DATETIME	记录最后更新时间

生成单词数据模型
$ gf gen dao

执行成功后，会生成下列文件：

internal/model/do/words.go
internal/model/entity/words.go
internal/dao/internal/words.go
internal/dao/words.go

## 新增单词
根据RESTful风格，新增应该使用POST方式，祭出我们的三板斧，无情的搬砖式开发。

添加 Api
api/words/v1/words.go
package v1

import "github.com/gogf/gf/v2/frame/g"


type ProficiencyLevel uint

const (
	ProficiencyLevel1 ProficiencyLevel = iota + 1
	ProficiencyLevel2
	ProficiencyLevel3
	ProficiencyLevel4
	ProficiencyLevel5
)

type CreateReq struct {
	g.Meta             `path:"words" method:"post" sm:"创建" tags:"单词"`
	Word               string           `json:"word" v:"required|length:1,100" dc:"单词"`
	Definition         string           `json:"definition" v:"required|length:1,300" dc:"单词定义"`
	ExampleSentence    string           `json:"example_sentence" v:"required|length:1,300" dc:"例句"`
	ChineseTranslation string           `json:"chinese_translation" v:"required|length:1,300" dc:"中文翻译"`
	Pronunciation      string           `json:"pronunciation" v:"required|length:1,100" dc:"发音"`
	ProficiencyLevel   ProficiencyLevel `json:"proficiency_level" v:"required|between:1,5" dc:"熟练度，1最低，5最高"`
}

type CreateRes struct {
}

在这里我们自定义了一个数据类型ProficiencyLevel，表示单词的掌握程度，并定义了五个枚举值：ProficiencyLevel1-5从低到高表示级别。

这种自定义类型加上固定枚举值的方式是一种高级的程序设计技巧，可以广泛用在各类状态上，比如订单状态，项目阶段等。新手在编程总喜欢使用int一把梭，最后造成代码里全是1,2,3...这种数字状态，导致代码的可读性和可维护性较差。

执行生成api命令
gf gen ctrl

编写Logic
同样的，定义Words对象，新建New函数用作实例化。

internal/logic/words/words.go
package words

import (
	"context"
	v1 "star/api/words/v1"
	"star/internal/dao"
	"star/internal/model/do"

	"github.com/gogf/gf/v2/errors/gerror"
)

type Words struct {
}

func New() *Words {
	return &Words{}
}

type CreateInput struct {
	Uid                uint
	Word               string
	Definition         string
	ExampleSentence    string
	ChineseTranslation string
	Pronunciation      string
	ProficiencyLevel   v1.ProficiencyLevel
}

func (w *Words) Create(ctx context.Context, in CreateInput) error {
	var cls = dao.Words.Columns()

	count, err := dao.Words.Ctx(ctx).
		Where(cls.Uid, in.Uid).
		Where(cls.Word, in.Word).Count()
	if err != nil {
		return err
	}
	if count > 0 {
		return gerror.New("单词已存在")
	}

	_, err = dao.Words.Ctx(ctx).Data(do.Words{
		Uid:                in.Uid,
		Word:               in.Word,
		Definition:         in.Definition,
		ExampleSentence:    in.ExampleSentence,
		ChineseTranslation: in.ChineseTranslation,
		Pronunciation:      in.Pronunciation,
		ProficiencyLevel:   in.ProficiencyLevel,
	}).Insert()
	if err != nil {
		return err
	}
	return nil
}


在Logic中我们也需要确保同一用户单词不能重复，和数据库保持一致。

account logic
单词表中保存有uid字段，我们需要在logic/users包中封装一个GetUid函数提供uid。

internal/logic/users/users_account.go
func (u *Users) GetUid(ctx context.Context) (uint, error) {  
    user, err := u.Info(ctx)  
    if err != nil {  
       return 0, err  
    }  
    return user.Id, nil  
}

Controller调用Logic
在创建单词的控制器中，我们需要调用account和words两个logic，我们将他封装到控制器中。

internal/controller/words/words_new.go
...


package words  
  
import (  
    "star/api/words"  
    usersLogic "star/internal/logic/users"  
    wordsLogic "star/internal/logic/words"  
)  
  
type ControllerV1 struct {  
    users *usersLogic.Users  
    words *wordsLogic.Words  
}  
  
func NewV1() words.IWordsV1 {  
    return &ControllerV1{  
        users: usersLogic.New(),  
        words: wordsLogic.New(),  
    }  
}

internal/controller/words/words_v1_create.go
package words  
  
import (  
    "context"  
  
    "star/api/words/v1"
    "star/internal/logic/words"
)  
  
func (c *ControllerV1) Create(ctx context.Context, req *v1.CreateReq) (res *v1.CreateRes, err error) {  
    uid, err := c.users.GetUid(ctx)  
    if err != nil {  
       return nil, err  
    }  
    err = c.words.Create(ctx, words.CreateInput {  
       Uid:                uid,  
       Word:               req.Word,  
       Definition:         req.Definition,  
       ExampleSentence:    req.ExampleSentence,  
       ChineseTranslation: req.ChineseTranslation,  
       Pronunciation:      req.Pronunciation,  
       ProficiencyLevel:   req.ProficiencyLevel, 
    })  
    return nil, err  
}

在Controller中调用两个Logic层级的方法：users.GetUid和words.Create来实现功能。注意，不要在words.Create中直接调用users.GetUid，这样会加重words包的耦合。

最佳实验是，尽量保证Logic函数的功能单一化，在Controller中多次调用Logic完成功能。

注册控制器
internal/cmd/cmd.go
package cmd  

...

var (  
    Main = gcmd.Command{  
       Name:  "main",  
       Usage: "main",  
       Brief: "start http server",  
       Func: func(ctx context.Context, parser *gcmd.Parser) (err error) {  
          s := g.Server()  
          s.Group("/", func(group *ghttp.RouterGroup) {  
             group.Middleware(ghttp.MiddlewareHandlerResponse)  
             group.Group("/v1", func(group *ghttp.RouterGroup) {  
                group.Bind(  
                   users.NewV1(),  
                )  
                group.Group("/", func(group *ghttp.RouterGroup) {  
                   group.Middleware(middleware.Auth)  
                   group.Bind(  
                      account.NewV1(),  
                      words.NewV1(),  
                   )  
                })  
             })  
          })  
          s.Run()  
          return nil  
       },  
    }  
)

控制器注册到与account.NewV1()同一个路由组下，确保能经过Auth中间件。
接口测试 这里有很多坑点，建议用apifox之类的接口请求软件来发送，不要用cmd或powershell会出乱码，如果非要用powershell要升到新版本如7.5.4以上
推荐使用apifox，可以使用apifox来导入你的openapi地址接口文档。
## PowerShell 版本7用以下命令 记得要换token呀
Invoke-WebRequest -Uri "http://127.0.0.1:8000/v1/words" `
  -Method POST `
  -Headers @{
    "Authorization" = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MSwiVXNlcm5hbWUiOiJvbGRtZSIsImV4cCI6MTc2NDc2OTQ0MH0.6zMX7ezw4w2lJIFLEtESas_ptLx9nCNbMLf0xleWpTg"
    "Content-Type" = "application/json; charset=utf-8"
  } `
  -Body '{
    "word": "example",
    "definition": "A representative form or pattern.",
    "example_sentence": "This is an example sentence.",
    "chinese_translation": "例子",
    "pronunciation": "ɪɡˈzɑːmp(ə)l",
    "proficiency_level": 3
  }'

{
    "code": 0,
    "message": "",
    "data": null
}

## 编辑单词
编辑单词使用PUT方式，代表更新资源。
添加 Api
api/words/v1/words.go
type UpdateReq struct {  
    g.Meta             `path:"words/{id}" method:"put" sm:"更新" tags:"单词"`  
    Id                 uint             `json:"id" v:"required"`  
    Word               string           `json:"word" v:"required|length:1,100" dc:"单词"`  
    Definition         string           `json:"definition" v:"required|length:1,300" dc:"单词定义"`  
    ExampleSentence    string           `json:"example_sentence" v:"required|length:1,300" dc:"例句"`  
    ChineseTranslation string           `json:"chinese_translation" v:"required|length:1,300" dc:"中文翻译"`  
    Pronunciation      string           `json:"pronunciation" v:"required|length:1,100" dc:"发音"`  
    ProficiencyLevel   ProficiencyLevel `json:"proficiency_level" v:"required|between:1,5" dc:"熟练度，1最低，5最高"`  
}  
  
type UpdateRes struct {  
}

定义完接口后执行生成命令
gf gen ctrl

编写Logic
internal/logic/words/words.go
package words  

...

type UpdateInput struct {  
    Uid                uint  
    Word               string  
    Definition         string  
    ExampleSentence    string  
    ChineseTranslation string  
    Pronunciation      string  
    ProficiencyLevel   v1.ProficiencyLevel  
}  
  
func (w *Words) Update(ctx context.Context, id uint, in UpdateInput) error {  
    var cls = dao.Words.Columns()  
  
    count, err := dao.Words.Ctx(ctx).  
       Where(cls.Uid, in.Uid).  
       Where(cls.Word, in.Word).  
       WhereNot(cls.Id, id).  
       Count()  
    if err != nil {  
       return err  
    }  
    if count > 0 {  
       return gerror.New("单词已存在")  
    }  
  
    _, err = dao.Words.Ctx(ctx).Data(do.Words{  
       Word:               in.Word,  
       Definition:         in.Definition,  
       ExampleSentence:    in.ExampleSentence,  
       ChineseTranslation: in.ChineseTranslation,  
       Pronunciation:      in.Pronunciation,  
       ProficiencyLevel:   in.ProficiencyLevel,  
    }).Where(cls.Id, id).Where(cls.Uid, in.Uid).Update()  
    if err != nil {  
       return err  
    }  
    return nil  
}

...

必须在ORM链式中加上Uid判断条件，以防止越权，后续的查询，删除动作同样如此。另外加上WhereNot，以忽略自身的单词重复检测。
Controller调用Logic
internal/controller/words/words_v1_update.go
package words  
  
import (  
    "context"  
  
    "star/api/words/v1"
    "star/internal/logic/words"
)  
  
func (c *ControllerV1) Update(ctx context.Context, req *v1.UpdateReq) (res *v1.UpdateRes, err error) {
    uid, err := c.users.GetUid(ctx)
	if err != nil {
		return nil, err
	}
    err = c.words.Update(ctx, req.Id, words.UpdateInput{
        Uid:                uid,
        Word:               req.Word,  
        Definition:         req.Definition,  
        ExampleSentence:    req.ExampleSentence,  
        ChineseTranslation: req.ChineseTranslation,  
        Pronunciation:      req.Pronunciation,  
        ProficiencyLevel:   req.ProficiencyLevel,  
    })  
    return nil, err  
}

接口测试
使用apifox导入接口，只选择新开发的这一个接口即可。
$ curl -X PUT http://127.0.0.1:8000/v1/words/1 \
     -H "Authorization: eyJhbGci...5U" \
     -H "Content-Type: application/json" \
     -d '{
           "word": "example_update",
           "definition": "A representative form or pattern.",
           "example_sentence": "This is an example sentence.",
           "chinese_translation": "例子2",
           "pronunciation": "ɪɡˈzɑːmp(ə)l",
           "proficiency_level": 3
         }'

{
    "code": 0,
    "message": "",
    "data": null
}

执行命令，查询数据是否正常更新：
$ SELECT * FROM words;

## 单词分页列表
查询单词分页列表使用GET方式，并且提供一些入参：

字段名	类型	json	valid	描述
Word	string	json:"word"	length:1,100	模糊查询单词
Page	int	json:"page"	min:1	页码，默认1
Size	int	json:"size"	between:1,100	每页数量，默认10
添加Api
定义一个结构体List保存一个单词的字段。在ListRes中返回一个List切片，表示单词列表，Total表示所有单词数量，返回给前端方便做分页操作。

api/words/v1/words.go
...

type List struct {
	Id               uint             `json:"id"`
	Word             string           `json:"word"`
	Definition       string           `json:"definition"`
	ProficiencyLevel ProficiencyLevel `json:"proficiencyLevel"`
}

type ListReq struct {
	g.Meta `path:"words" method:"get" sm:"列表" tags:"单词"`
	Word   string `json:"word" v:"length:1,100" dc:"模糊查询单词"`
	Page   int    `json:"page" v:"min:1" dc:"页码，默认1"`
	Size   int    `json:"size" v:"between:1,100" dc:"每页数量，默认10"`
}

type ListRes struct {
	List  []List `json:"list"`
	Total uint   `json:"total"`
}

定义完接口后执行生成命令
gf gen ctrl

编写Logic
internal/logic/words/words.go
...

type ListInput struct {  
    Uid  uint  
    Word string  
    Page int  
    Size int  
}  
  
func (w *Words) List(ctx context.Context, in ListInput) (list []entity.Words, total int, err error) {  
    // 对于查询初始值的处理  
    if in.Page == 0 {  
       in.Page = 1  
    }  
    if in.Size == 0 {  
       in.Size = 15  
    }  
  
    var (  
       cls = dao.Words.Columns()  
       orm = dao.Words.Ctx(ctx)  
    )  
    // 组成查询链  
    if in.Uid > 0 {  
       orm = orm.Where(cls.Uid, in.Uid)  
    }  
  
    // 模糊查询  
    if len(in.Word) != 0 {  
       orm = orm.WhereLike(cls.Word, "%"+in.Word+"%")  
    }  
    orm = orm.OrderDesc(cls.CreatedAt).OrderDesc(cls.Id).Page(in.Page, in.Size)  
    if err = orm.ScanAndCount(&list, &total, true); err != nil {  
       return  
    }  
    return  
}

上述代码用到了orm.WhereLike(cls.Word, "%"+in.Word+"%")，它是模糊查询的意思，最终会生成word LIKE '%{word}%' 子句。

AllAndCount用于同时查询数据记录列表及总数量，一般用于分页查询场景中，简化分页查询逻辑。
Controller调用Logic
internal/controller/words/words_v1_list.go
package words  
  
import (  
    "context"  
  
    "star/api/words/v1"
    "star/internal/logic/words"
)  
  
func (c *ControllerV1) List(ctx context.Context, req *v1.ListReq) (res *v1.ListRes, err error) {  
    uid, err := c.users.GetUid(ctx)  
    if err != nil {  
        return nil, err  
    }  
    wordList, total, err := c.words.List(ctx, words.ListInput{  
        Uid:  uid,  
        Word: req.Word,  
        Page: req.Page,  
        Size: req.Size,  
    })  
    if err != nil {  
        return nil, err  
    }  
  
    var list []v1.List  
    for _, v := range wordList {  
        list = append(list, v1.List{  
            Id:               v.Id,  
            Word:             v.Word,  
            Definition:       v.Definition,  
            ProficiencyLevel: v1.ProficiencyLevel(v.ProficiencyLevel),  
        })  
    }  
  
    return &v1.ListRes{  
        List:  list,  
        Total: uint(total),  
    }, nil  
}


## 单词详情
单词详情同样使用GET方式，用作获取单词的详细信息，会包含例句，中文翻译等列表中不存在的字段。

添加Api
api/words/v1/words.go
...

type DetailReq struct {  
    g.Meta `path:"words/{id}" method:"get" sm:"详情" tags:"单词"`  
    Id     uint `json:"id" v:"required"`  
}  
  
type DetailRes struct {  
    Id                 uint             `json:"id"`  
    Word               string           `json:"word"`  
    Definition         string           `json:"definition"`  
    ExampleSentence    string           `json:"exampleSentence"`  
    ChineseTranslation string           `json:"chineseTranslation"`  
    Pronunciation      string           `json:"pronunciation"`  
    ProficiencyLevel   ProficiencyLevel `json:"proficiencyLevel"`  
    CreatedAt          *gtime.Time      `json:"createdAt"`  
    UpdatedAt          *gtime.Time      `json:"updatedAt"`  
}

words/{id}是一种模糊路由匹配方式，它会识别类似words/1，words/2，words/abc这种路由，并将匹配到的值赋予Id字段。Id字段的类型是uint，如果值不合法，则会使用uint的零值。比如访问words/abc，Id字段的值就会是0。

编写Logic
internal/logic/words/words.go
...

func (w *Words) Detail(ctx context.Context, uid, id uint) (word *entity.Words, err error) {  
    var (  
       cls = dao.Words.Columns()  
       orm = dao.Words.Ctx(ctx)  
    )  
    orm = orm.Where(cls.Id, id)  
    if uid > 0 {  
       orm = orm.Where(cls.Uid, uid)  
    }  
    err = orm.Scan(&word)  
    return  
}

Controller调用Logic
internal/controller/words/words_v1_detail.go
package words  
  
import (  
    "context"  
  
    "star/api/words/v1"
)  
  
func (c *ControllerV1) Detail(ctx context.Context, req *v1.DetailReq) (res *v1.DetailRes, err error) {  
    uid, err := c.users.GetUid(ctx)  
    if err != nil {  
        return nil, err  
    }  
  
    word, err := c.words.Detail(ctx, uid, req.Id)  
    if err != nil {  
        return nil, err  
    }  
  
    return &v1.DetailRes{  
        Id:                 word.Id,  
        Word:               word.Word,  
        Definition:         word.Definition,  
        ExampleSentence:    word.ExampleSentence,  
        ChineseTranslation: word.ChineseTranslation,  
        Pronunciation:      word.Pronunciation,  
        ProficiencyLevel:   v1.ProficiencyLevel(word.ProficiencyLevel),  
        CreatedAt:          word.CreatedAt,  
        UpdatedAt:          word.UpdatedAt,  
    }, nil  
}

接口测试

$ curl -X GET http://127.0.0.1:8000/v1/words/1 \
     -H "Authorization: eyJhbGci...5U" \
     -H "Content-Type: application/json" \

{
    "code": 0,
    "message": "",
    "data": {
        "id": 1,
        "word": "example_update",
        "definition": "A representative form or pattern.",
        "exampleSentence": "This is an example sentence.",
        "chineseTranslation": "例子",
        "pronunciation": "ɪɡˈzɑːmp(ə)l",
        "proficiencyLevel": 3,
        "createdAt": "2024-11-14 15:40:54",
        "updatedAt": "2024-11-14 16:09:37"
    }
}

## 删除单词
删除单词使用DELETE方式。
添加Api
api/words/v1/words.go
...
type DeleteReq struct {  
    g.Meta `path:"words/{id}" method:"delete" sm:"删除" tags:"单词"`  
    Id     uint `json:"id" v:"required"`  
}  
  
type DeleteRes struct {  
}

用命令生成相关控制器
 gf gen ctrl

 编写Logic
internal/logic/words/words.go
...

func (w *Words) Delete(ctx context.Context, uid, id uint) (err error) {  
    var (  
       cls = dao.Words.Columns()  
       orm = dao.Words.Ctx(ctx)  
    )  
    orm = orm.Where(cls.Id, id)  
    if uid > 0 {  
       orm = orm.Where(cls.Uid, uid)  
    }  
    _, err = orm.Delete()  
    return  
}

Controller调用Logic
internal/controller/words/words_v1_delete.go
package words  
  
import (  
    "context"  
  
    "star/api/words/v1"
)  
  
func (c *ControllerV1) Delete(ctx context.Context, req *v1.DeleteReq) (res *v1.DeleteRes, err error) {  
    uid, err := c.users.GetUid(ctx)  
    if err != nil {  
       return nil, err  
    }  
  
    err = c.words.Delete(ctx, uid, req.Id)  
    return  
}

接口测试
$ curl -X DELETE http://127.0.0.1:8000/v1/words/1 \
     -H "Authorization: eyJhbGci...5U" \
     -H "Content-Type: application/json" \

{
    "code": 0,
    "message": "",
    "data": null
}

## 单词管理总结
在本章节中，我们基于RESTful开发了单词相关的基础功能：

创建单词（Create）：通过POST请求，将单词及其相关信息存储到数据库中;
读取单词（Read）：通过GET请求，获取单词及其详细信息，支持分页查询和word模糊查询；
更新单词（Update）：通过PUT请求，更新已存在单词的信息；
删除单词（Delete）：通过DELETE请求，删除指定的单词。
学会了一些进阶技巧：

使用枚举值管理状态；
分层数据模型的思想，限制透传；
联合索引；
分页查询；
模糊查询。

# 学习单词

## 前置说明
在本章中我们将进一步丰富星辰英语本，为用户提供两个实用功能：

随机获取若干单词，方便用户复习；
设置单词掌握程度，清晰复习目标。
并在此过程中深入学习RESTful，提供更为丰富的接口。

## 随机获取若干单词
随机获取若干单词与获取单词分页列表大同小异：

没有分页查询，转而使用随机查询；
没有模糊查询；
返回的数据基本一致。
添加Api
api/words/v1/words_learn.go

package v1  
  
import (  
    "github.com/gogf/gf/v2/frame/g"  
)  
  
type RandListReq struct {  
    g.Meta `path:"words/rand" method:"get" sm:"随机获取单词列表" tags:"单词"`  
    Limit  uint `json:"limit" v:"between:1,300" dc:"限制个数，默认50"`  
}  
  
type RandListRes struct {  
    List []List `json:"list"`  
}

使用命令生成控制器
gf gen ctrl

RandListReq提供Limit字段，表示想要获取的个数，范围在1-300。RandListRes使用与单词分页列表一样的数据结构，但是少了Total字段。

words/rand是一种精确匹配，它的优先级要高于单词详情接口：words/{id}。

编写Logic
internal/logic/words/words_learn.go
package words  
  
import (  
    "context"  
  
    "github.com/gogf/gf/v2/errors/gerror"
    "star/internal/dao"
    "star/internal/model"
    "star/internal/model/entity"
)  
  
func (w *Words) Rand(ctx context.Context, uid, limit uint) ([]entity.Words, error) {  
    if limit <= 0 {  
        limit = 50  
    }  
    var (  
        err  error  
        cls  = dao.Words.Columns()  
        orm  = dao.Words.Ctx(ctx)  
        list = make([]entity.Words, limit)  
    )  
    if uid > 0 {  
        orm = orm.Where(cls.Uid, uid)  
    }  
    err = orm.Limit(int(limit)).OrderRandom().Scan(&list)  
    return list, err  
}

OrderRandom是GoFrame ORM提供的随机查询方法，Limit方法用于限制查询个数

Controller调用Logic
internal/controller/words/words_v1_rand_list.go
package words  
  
import (  
    "context"  
  
    "star/api/words/v1"
)  
  
func (c *ControllerV1) RandList(ctx context.Context, req *v1.RandListReq) (res *v1.RandListRes, err error) {  
    uid, err := c.users.GetUid(ctx)  
    if err != nil {  
        return nil, err  
    }  
  
    wordList, err := c.words.Rand(ctx, uid, req.Limit)  
    if err != nil {  
        return nil, err  
    }  
  
    var list []v1.List  
    for _, v := range wordList {  
        list = append(list, v1.List{  
            Id:               v.Id,  
            Word:             v.Word,  
            Definition:       v.Definition,  
            ProficiencyLevel: v1.ProficiencyLevel(v.ProficiencyLevel),  
        })  
    }  
  
    return &v1.RandListRes{  
        List: list,  
    }, nil  
}

接口测试
准备一些测试数据并测试，这里为了节省篇幅就不再详细介绍了。
$ curl -X GET http://127.0.0.1:8000/v1/words/rand \
     -H "Authorization: eyJhbGci...5U" \
     -H "Content-Type: application/json" \

{
    "code": 0,
    "message": "",
    "data": {
        "list": [
            ...
        ]
    }
}

设置掌握程度
设置掌握程度的功能本质上是一种编辑，只改变ProficiencyLevel一个字段，所以这里使用PATCH方式比PUT更为合适。

添加Api
api/words/v1/words_learn.go
...

type SetLevelReq struct {
	g.Meta `path:"words/{id}/level" method:"patch" sm:"设置掌握熟练度" tags:"单词"`
	Id     uint             `json:"id" v:"required"`
	Level  ProficiencyLevel `json:"level" v:"required|between:1,5"`
}

type SetLevelRes struct {
}

使用命令生成控制层相关代码
 gf gen ctrl

 words/{id}/level和words/level/{id}这两种路由风格均可，但是前者更符合资源层级关系，推荐使用。

编写Logic
internal/logic/words/words_learn.go
...

// SetLevel 设置单词熟练度  
func (w *Words) SetLevel(ctx context.Context, uid, id uint, level v1.ProficiencyLevel) error {  
    if level < 0 || level > 5 {  
       return gerror.New("熟练度值不合法")  
    }  
  
    var (  
       cls = dao.Words.Columns()  
       orm = dao.Words.Ctx(ctx)  
    )  
    if uid > 0 {  
       orm = orm.Where(cls.Uid, uid)  
    }  
  
    _, err := orm.Data(cls.ProficiencyLevel, level).Where(cls.Id, id).Update()  
    return err  
}

为了防止数据异常，我们要在入库前检测等级是否在1-5之间。

Controller调用Logic
internal/controller/words/words_v1_set_level.go
package words  
  
import (  
    "context"  
  
    "star/api/words/v1"
)  
  
func (c *ControllerV1) SetLevel(ctx context.Context, req *v1.SetLevelReq) (res *v1.SetLevelRes, err error) {  
    uid, err := c.users.GetUid(ctx)  
    if err != nil {  
       return nil, err  
    }  
  
    err = c.words.SetLevel(ctx, uid, req.Id, req.Level)  
    return nil, err  
}

接口测试
$ curl -X PATCH http://127.0.0.1:8000/v1/words/1/level \
     -H "Authorization: eyJhbGci...5U" \
     -H "Content-Type: application/json" \
     -d '{
           "level": 5
         }'

{
    "code": 0,
    "message": "",
    "data": null
}

在本章节中，我们开发了学习单词的相关功能：

获取随机若干单词，学会了随机查询；
使用PATCH方式加深RESTful的理解。

附言
首先，感谢每个读者能够耐心看完本书！然后，这里还有一些学习方向提供给大家。作者本人水平有限，不足之处还请海涵。希望大家事业能够步步高升，蒸蒸日上!

进一步的学习方向与建议
在本书所有开发的功能中，作者预留了一些业务优化空间，不妨试试？

中间件的进一步使用，新增后置中间件，自定义错误信息；
将Jwtkey纳入到config.yaml中，而不是直接存放在代码中；
实现JWT的黑白名单机制；
新增/编辑单词时没有对入库数据进行验证，比如单词掌握程度。
在优化这些业务的同时，您需要大量的查询相关文档，在这个过程中，您会加深GoFrame乃至Golang的理解。

		// 从配置文件读取 JWT 密钥
		jwtSecret := g.Cfg().MustGet(context.Background(), "jwt.secret").String()