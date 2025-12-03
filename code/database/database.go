package main

/**
先运行以下命令再
# 1. 进入项目目录
cd E:\vsked\project\vskedgolang\code\database

# 2. 初始化模块（替换 your-app 为你的项目名）
go mod init godatabasetest

# 3. 下载 MySQL 驱动
go get github.com/go-sql-driver/mysql

# 4. 运行程序
go run database.go
*/

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	_ "github.com/go-sql-driver/mysql" // 匿名导入，注册驱动
)

// 定义结构体（可选，用于映射查询结果）
type User struct {
	ID      int
	Name    string
	Email   string
	AddTime time.Time
}

func main() {
	// ========== 1. 配置数据库连接信息 ==========
	// 格式: "user:password@tcp(host:port)/dbname?param=value"
	dsn := "golangtest:golangtest@tcp(localhost:3306)/golangtest?charset=utf8mb4&parseTime=True&loc=Local"

	// ========== 2. 打开数据库连接 ==========
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		log.Fatal("数据库连接失败:", err)
	}
	defer db.Close() // 程序退出前关闭连接

	// ========== 3. 测试连接是否有效 ==========
	err = db.Ping()
	if err != nil {
		log.Fatal("数据库 Ping 失败:", err)
	}
	fmt.Println("✅ 数据库连接成功！")

	// ========== 4. 查询单条记录 ==========
	fmt.Println("\n--- 查询单条记录 ---")
	var user User
	querySingle := "SELECT id, name, email, addtime FROM user WHERE id = ?"
	err = db.QueryRow(querySingle, 1).Scan(&user.ID, &user.Name, &user.Email, &user.AddTime)
	if err != nil {
		if err == sql.ErrNoRows {
			fmt.Println("未找到用户")
		} else {
			log.Fatal("查询单条记录失败:", err)
		}
	} else {
		fmt.Printf("找到用户: %+v\n", user)
	}

	// ========== 5. 查询多条记录 ==========
	fmt.Println("\n--- 查询多条记录 ---")
	queryAll := "SELECT id, name, email, addtime FROM user LIMIT 5"
	rows, err := db.Query(queryAll)
	if err != nil {
		log.Fatal("查询多条记录失败:", err)
	}
	defer rows.Close() // 必须关闭 rows！

	// 遍历结果集
	var users []User
	for rows.Next() {
		var u User
		err := rows.Scan(&u.ID, &u.Name, &u.Email, &u.AddTime)
		if err != nil {
			log.Fatal("扫描行失败:", err)
		}
		users = append(users, u)
	}

	// 检查遍历错误
	if err = rows.Err(); err != nil {
		log.Fatal("遍历结果集出错:", err)
	}

	// 打印结果
	for _, u := range users {
		fmt.Printf("用户: %+v\n", u)
	}

	// ========== 6. 带参数的查询（防止 SQL 注入）==========
	fmt.Println("\n--- 带参数查询（防注入） ---")
	var count int
	err = db.QueryRow("SELECT COUNT(*) FROM user WHERE name LIKE ?", "%工%").Scan(&count)
	if err != nil {
		log.Fatal("计数查询失败:", err)
	}
	fmt.Printf("名字含'工'的用户数: %d\n", count)
}
