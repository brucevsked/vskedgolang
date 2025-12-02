package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	// 1. 创建请求
	req, err := http.NewRequest("GET", "https://httpbin.org/headers", nil)
	if err != nil {
		log.Fatal(err)
	}

	// 2. 设置请求头（你发给服务器的）
	req.Header.Set("a", "1")
	req.Header.Set("X-Custom-ID", "12345")

	// 3. 发送请求
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	// 4. 读取响应头（服务器返回给你的）
	fmt.Println("响应状态:", resp.Status)

	// 打印所有响应头
	fmt.Println("\n--- 响应头 (Response Headers) ---")
	for key, values := range resp.Header {
		fmt.Printf("%s: %v\n", key, values)
	}

	// 获取特定响应头
	server := resp.Header.Get("Server")
	fmt.Printf("\nServer header: %s\n", server)
}
