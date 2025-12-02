package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"time"
)

func main() {
	// 1. 设置搜索关键字
	keyword := "Go 语言"

	// 2. 构造百度搜索 URL
	// 百度搜索 URL 格式: https://www.baidu.com/s?wd=关键词
	baseURL := "https://www.baidu.com/s"
	params := url.Values{}
	params.Add("wd", keyword) // wd 是百度搜索的关键字参数

	fullURL := baseURL + "?" + params.Encode()
	fmt.Printf("正在搜索: %s\n", keyword)
	fmt.Printf("请求 URL: %s\n\n", fullURL)

	// 3. 创建 HTTP 客户端（可选：设置超时）
	client := &http.Client{
		Timeout: 10 * time.Second, // 需要导入 "time"
	}

	// 4. 创建请求（并设置 User-Agent 模拟浏览器）
	req, err := http.NewRequest("GET", fullURL, nil)
	if err != nil {
		log.Fatal("创建请求失败:", err)
	}

	// 设置 User-Agent 避免被识别为爬虫
	req.Header.Set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
	req.Header.Set("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
	req.Header.Set("Accept-Language", "zh-CN,zh;q=0.9,en;q=0.8")
	req.Header.Set("Connection", "keep-alive")
	req.Header.Set("Upgrade-Insecure-Requests", "1")
	req.Header.Set("Sec-Fetch-Dest", "document")
	req.Header.Set("Sec-Fetch-Mode", "navigate")
	req.Header.Set("Sec-Fetch-Site", "none")
	req.Header.Set("Sec-Fetch-User", "?1")
	req.Header.Set("Cache-Control", "max-age=0")

	// 5. 发送请求
	resp, err := client.Do(req)
	if err != nil {
		log.Fatal("请求失败:", err)
	}
	defer resp.Body.Close()

	// 6. 读取响应
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatal("读取响应失败:", err)
	}

	// 7. 输出结果
	fmt.Printf("状态码: %s\n", resp.Status)
	fmt.Printf("响应长度: %d 字节\n", len(body))

	// 打印前 1000 个字符（避免输出过长）
	if len(body) > 1000 {
		fmt.Printf("响应内容（前 1000 字符）:\n%s\n...", string(body[:1000]))
	} else {
		fmt.Printf("响应内容:\n%s\n", string(body))
	}
}
