package main

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/redis/go-redis/v9"
)

/*
先要运行以下命令，安装redis相关驱动再连接
go mod init goredistest
go get github.com/redis/go-redis/v9
*/
func main() {
	// ========== 1. 连接 Redis ==========
	ctx := context.Background()
	rdb := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379", // Redis 地址
		Password: "Y4yhl9tbf110",   // 无密码（如有密码则填写）
		DB:       3,                // 使用数据库 0
	})

	// 测试连接
	if err := rdb.Ping(ctx).Err(); err != nil {
		log.Fatal("Redis 连接失败:", err)
	}
	fmt.Println(" Redis 连接成功！")

	// ========== 2. 字符串操作 ==========
	fmt.Println("\n--- 字符串操作 ---")
	// SET
	err := rdb.Set(ctx, "name", "GoFrame", 0).Err()
	if err != nil {
		log.Fatal("SET 失败:", err)
	}
	// GET
	name, err := rdb.Get(ctx, "name").Result()
	if err != nil {
		log.Fatal("GET 失败:", err)
	}
	fmt.Printf("GET name: %s\n", name)

	// ========== 3. 哈希操作 ==========
	fmt.Println("\n--- 哈希操作 ---")
	// HSET
	err = rdb.HSet(ctx, "user:1", map[string]interface{}{
		"name": "Alice",
		"age":  30,
	}).Err()
	if err != nil {
		log.Fatal("HSET 失败:", err)
	}
	// HGET
	userName, err := rdb.HGet(ctx, "user:1", "name").Result()
	if err != nil {
		log.Fatal("HGET 失败:", err)
	}
	fmt.Printf("HGET user:1 name: %s\n", userName)

	// ========== 4. 列表操作 ==========
	fmt.Println("\n--- 列表操作 ---")
	// LPUSH
	err = rdb.LPush(ctx, "tasks", "task1", "task2").Err()
	if err != nil {
		log.Fatal("LPUSH 失败:", err)
	}
	// LRANGE
	tasks, err := rdb.LRange(ctx, "tasks", 0, -1).Result()
	if err != nil {
		log.Fatal("LRANGE 失败:", err)
	}
	fmt.Printf("LRANGE tasks: %v\n", tasks)

	// ========== 5. 集合操作 ==========
	fmt.Println("\n--- 集合操作 ---")
	// SADD
	err = rdb.SAdd(ctx, "tags", "go", "redis", "web").Err()
	if err != nil {
		log.Fatal("SADD 失败:", err)
	}
	// SMEMBERS
	tags, err := rdb.SMembers(ctx, "tags").Result()
	if err != nil {
		log.Fatal("SMEMBERS 失败:", err)
	}
	fmt.Printf("SMEMBERS tags: %v\n", tags)

	// ========== 6. 有序集合操作 ==========
	fmt.Println("\n--- 有序集合操作 ---")
	// ZADD
	err = rdb.ZAdd(ctx, "leaderboard", redis.Z{
		Score:  100,
		Member: "player1",
	}, redis.Z{
		Score:  95,
		Member: "player2",
	}).Err()
	if err != nil {
		log.Fatal("ZADD 失败:", err)
	}
	// ZRANGE
	players, err := rdb.ZRangeWithScores(ctx, "leaderboard", 0, -1).Result()
	if err != nil {
		log.Fatal("ZRANGE 失败:", err)
	}
	for _, p := range players {
		fmt.Printf("Player: %s, Score: %.0f\n", p.Member, p.Score)
	}

	// ========== 7. 键操作 ==========
	fmt.Println("\n--- 键操作 ---")
	// EXISTS
	exists, err := rdb.Exists(ctx, "name").Result()
	if err != nil {
		log.Fatal("EXISTS 失败:", err)
	}
	fmt.Printf("Key 'name' exists: %t\n", exists)

	// EXPIRE
	err = rdb.Expire(ctx, "name", 10*time.Second).Err()
	if err != nil {
		log.Fatal("EXPIRE 失败:", err)
	}
	fmt.Println("Key 'name' 将在 10 秒后过期")

	// ========== 8. 事务操作 ==========
	fmt.Println("\n--- 事务操作 ---")
	// WATCH + MULTI
	err = rdb.Watch(ctx, func(tx *redis.Tx) error {
		// 获取当前值
		val, err := tx.Get(ctx, "counter").Int64()
		if err != nil && err != redis.Nil {
			return err
		}
		// 乐观锁：仅当值未被其他客户端修改时才提交
		_, err = tx.TxPipelined(ctx, func(pipe redis.Pipeliner) error {
			pipe.Set(ctx, "counter", val+1, 0)
			return nil
		})
		return err
	}, "counter")
	if err != nil && err != redis.TxFailedErr {
		log.Fatal("事务失败:", err)
	}
	counter, _ := rdb.Get(ctx, "counter").Int64()
	fmt.Printf("事务后 counter: %d\n", counter)

	// ========== 9. 发布/订阅 ==========
	fmt.Println("\n--- 发布/订阅 ---")
	// 启动订阅者（goroutine）
	sub := rdb.Subscribe(ctx, "news")
	go func() {
		msg, err := sub.ReceiveMessage(ctx)
		if err != nil {
			log.Fatal("订阅失败:", err)
		}
		fmt.Printf("收到消息: %s (频道: %s)\n", msg.Payload, msg.Channel)
		sub.Close()
	}()

	// 发布消息
	time.Sleep(100 * time.Millisecond) // 确保订阅者已启动
	err = rdb.Publish(ctx, "news", "Hello Redis!").Err()
	if err != nil {
		log.Fatal("发布失败:", err)
	}

	// 等待订阅消息处理完成
	time.Sleep(500 * time.Millisecond)

	// ========== 10. 关闭连接 ==========
	fmt.Println("\n--- 清理 ---")
	// 删除测试数据
	// rdb.FlushDB(ctx)
	fmt.Println("测试数据已清理，程序结束")
}
