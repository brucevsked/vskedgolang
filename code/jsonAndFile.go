package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"reflect"
)

// 定义用户结构体（字段首字母大写，才能被 json 包访问）
type User struct {
	ID     int      `json:"id"`
	Name   string   `json:"name"`
	Email  string   `json:"email,omitempty"` // 如果为空则不输出
	Age    int      `json:"age"`
	Active bool     `json:"active"`
	Tags   []string `json:"tags"`
	City   string   `json:"city"` // 简化地址为城市
}

func main() {
	filename := "users20251202.json"

	// ========== 1. 创建结构体数据 ==========
	users := []User{
		{ID: 1, Name: "Alice", Email: "alice@example.com", Age: 30, Active: true, Tags: []string{"developer", "gopher"}, City: "Paris"},
		{ID: 2, Name: "Bob", Age: 25, Active: false, Tags: []string{"student"}, City: "Cayenne"},
		{ID: 3, Name: "Charlie", Email: "", Age: 35, Active: true, Tags: []string{"manager"}, City: "New York"}, // Email 为空，不会出现在 JSON 中
	}

	// ========== 2. 序列化并保存到文件 ==========
	fmt.Println("正在将结构体序列化为 JSON 并保存到文件...")

	file, err := os.Create(filename)
	if err != nil {
		log.Fatal("无法创建文件:", err)
	}
	defer file.Close()

	// 使用 json.Encoder 直接写入文件（更高效）
	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "  ") // 美化输出

	if err := encoder.Encode(users); err != nil {
		log.Fatal("JSON 编码失败:", err)
	}

	fmt.Printf("数据已保存到 %s\n\n", filename)

	// ========== 3. 从文件读取并反序列化 ==========
	fmt.Println("正在从文件读取 JSON 并反序列化为结构体...")

	file, err = os.Open(filename)
	if err != nil {
		log.Fatal("无法打开文件:", err)
	}
	defer file.Close()

	var loadedUsers []User
	decoder := json.NewDecoder(file)
	if err := decoder.Decode(&loadedUsers); err != nil {
		log.Fatal("JSON 解码失败:", err)
	}

	fmt.Println("读取成功！反序列化后的数据：")
	for _, u := range loadedUsers {
		fmt.Printf("- ID: %d, Name: %s, Email: %s, Age: %d, Active: %t, Tags: %v, City: %s\n",
			u.ID, u.Name, u.Email, u.Age, u.Active, u.Tags, u.City)
	}
	// ========== 4. 验证数据一致性（使用 reflect.DeepEqual）==========
	fmt.Println("\n验证：原始数据与加载数据是否一致？")
	if len(users) != len(loadedUsers) {
		fmt.Println(" 长度不一致")
	} else {
		match := true
		for i := range users {
			if !reflect.DeepEqual(users[i], loadedUsers[i]) {
				match = false
				break
			}
		}
		if match {
			fmt.Println("数据完全一致！")
		} else {
			fmt.Println(" 数据不一致")
		}
	}
}
