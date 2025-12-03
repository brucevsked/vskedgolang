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

上面已经生成好数据模型了，那我们开始三板斧咯。

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