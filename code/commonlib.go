package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"
	"strings"
	"sync"
	"time"
)

// 定义结构体（注意字段首字母大写，否则 JSON 无法访问）
type Address struct {
	City   string `json:"city"`
	Street string `json:"street"`
}

type User struct {
	ID      int      `json:"id"`
	Name    string   `json:"name"`
	Email   string   `json:"email,omitempty"` // 如果为空则不输出
	Age     int      `json:"age"`
	Active  bool     `json:"active"`
	Tags    []string `json:"tags"`
	Address Address  `json:"address"`
	Ignored string   `json:"-"` // 不参与 JSON 编解码
}

// 1. sync.Mutex：保护共享计数器
var (
	counter int
	mu      sync.Mutex
)

// 2. sync.Once：确保初始化只执行一次
var once sync.Once
var config string

func initConfig() {
	config = "loaded from file"
	fmt.Println("Config initialized!")
}

// 3. sync.WaitGroup：等待所有任务完成
func worker(id int, wg *sync.WaitGroup) {
	defer wg.Done()
	time.Sleep(time.Millisecond * 100)
	fmt.Printf("Worker %d done\n", id)
}

func main() {
	fmt.Println("==========this is just start")

	path := os.Getenv("PATH")
	fmt.Println(path)

	// 1. 创建并写入源文件
	srcFile, err := os.Create("srcFile20251202.txt")
	if err != nil {
		log.Fatal("Failed to create src file:", err)
	}
	_, err = srcFile.WriteString("1this is first line 1\n")
	if err != nil {
		log.Fatal("Write failed:", err)
	}
	_, err = srcFile.WriteString("2 that is second line 2\n")
	if err != nil {
		log.Fatal("Write failed:", err)
	}
	srcFile.Close() // 关闭以便重新读取

	// 2. 打开源文件用于读取
	srcFile, err = os.Open("srcFile20251202.txt")
	if err != nil {
		log.Fatal("Failed to open src file:", err)
	}
	defer srcFile.Close()

	// 3. 创建目标文件
	dstFile, err := os.Create("dstFile20251202a.txt")
	if err != nil {
		log.Fatal("Failed to create dst file:", err)
	}
	defer dstFile.Close()

	// 4. 复制
	_, err = io.Copy(dstFile, srcFile)
	if err != nil {
		log.Fatal("Copy failed:", err)
	}

	fmt.Println("File copied successfully!")
	// ========== 1. Go 结构体 → JSON（Marshal）==========
	user := User{
		ID:     101,
		Name:   "Alice",
		Email:  "",
		Age:    30,
		Active: true,
		Tags:   []string{"developer", "gopher"},
		Address: Address{
			City:   "Paris",
			Street: "Rue de Rivoli",
		},
		Ignored: "this will not appear in JSON",
	}

	// 只保留 MarshalIndent（因为你只需要格式化输出）
	jsonStr, err := json.MarshalIndent(user, "", "  ")
	if err != nil {
		log.Fatal("JSON marshal indent failed:", err)
	}

	fmt.Println("Go struct → JSON:")
	fmt.Println(string(jsonStr))
	fmt.Println()

	// 转为可读字符串（带缩进）
	jsonStr, err = json.MarshalIndent(user, "", "  ")
	if err != nil {
		log.Fatal("JSON marshal indent failed:", err)
	}

	fmt.Println("Go struct → JSON:")
	fmt.Println(string(jsonStr))
	fmt.Println()

	// ========== 2. JSON → Go 结构体（Unmarshal）==========
	jsonInput := `{
		"id": 102,
		"name": "Bob",
		"age": 25,
		"active": false,
		"tags": ["student"],
		"address": {
			"city": "Cayenne",
			"street": "Avenue de Gaulle"
		}
	}`

	var user2 User
	err = json.Unmarshal([]byte(jsonInput), &user2)
	if err != nil {
		log.Fatal("JSON unmarshal failed:", err)
	}

	fmt.Println("JSON → Go struct:")
	fmt.Printf("User: %+v\n", user2)
	fmt.Println()

	// ========== 3. 处理未知结构的 JSON（使用 map[string]interface{}）==========
	unknownJSON := `{"name": "Charlie", "score": 95, "verified": true}`
	var result map[string]interface{}
	json.Unmarshal([]byte(unknownJSON), &result)

	fmt.Println("Dynamic JSON parsing:")
	for k, v := range result {
		switch v := v.(type) {
		case string:
			fmt.Printf("  %s: %q (string)\n", k, v)
		case float64: // JSON number 默认解析为 float64
			fmt.Printf("  %s: %v (number)\n", k, v)
		case bool:
			fmt.Printf("  %s: %v (bool)\n", k, v)
		}
	}
	fmt.Println()

	// ========== 4. 流式编码/解码（处理大文件或网络流）==========
	fmt.Println("Streaming JSON (Encoder/Decoder):")
	var buf strings.Builder
	encoder := json.NewEncoder(&buf)
	decoder := json.NewDecoder(strings.NewReader(jsonInput))

	// 解码
	var user3 User
	decoder.Decode(&user3)
	// 编码
	encoder.Encode(user3)

	fmt.Println("Stream result:", strings.TrimSpace(buf.String()))

	// ========== 示例 1: sync.Mutex（互斥锁）==========
	fmt.Println("=== Mutex: Safe Counter ===")
	var wg1 sync.WaitGroup
	for i := 0; i < 10; i++ {
		wg1.Add(1)
		go func() {
			defer wg1.Done()
			mu.Lock()
			counter++ // 安全递增
			mu.Unlock()
		}()
	}
	wg1.Wait()
	fmt.Printf("Final counter: %d\n\n", counter)

	// ========== 示例 2: sync.Once（一次性初始化）==========
	fmt.Println("=== Once: Initialize Config ===")
	for i := 0; i < 3; i++ {
		go func() {
			once.Do(initConfig) // 只会执行一次
		}()
	}
	time.Sleep(time.Millisecond * 10) // 等待 goroutine 执行
	fmt.Printf("Config: %s\n\n", config)

	// ========== 示例 3: sync.WaitGroup（等待任务完成）==========
	fmt.Println("=== WaitGroup: Parallel Workers ===")
	var wg2 sync.WaitGroup
	for i := 1; i <= 5; i++ {
		wg2.Add(1)
		go worker(i, &wg2)
	}
	wg2.Wait()
	fmt.Println("All workers finished!\n")

	// ========== 示例 4: sync.Pool（对象复用）==========
	fmt.Println("=== Pool: Reuse Objects ===")
	// 创建一个缓冲区池
	var bufferPool = sync.Pool{
		New: func() interface{} {
			fmt.Println("Creating new buffer")
			return make([]byte, 0, 1024)
		},
	}

	// 获取对象
	buf1 := bufferPool.Get().([]byte)
	buf1 = append(buf1, "hello"...)
	fmt.Printf("Buffer 1: %s\n", string(buf1))

	// 归还对象（重要！）
	bufferPool.Put(buf1)

	// 再次获取（应复用）
	buf2 := bufferPool.Get().([]byte)
	fmt.Printf("Buffer 2 (reused): len=%d, cap=%d\n", len(buf2), cap(buf2))
	bufferPool.Put(buf2)
}
