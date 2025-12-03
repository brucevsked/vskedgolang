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