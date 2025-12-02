package main

import (
	"fmt"
	"net/http"
)

// 处理 /hello 请求
func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, you requested: %s\n", r.URL.Path)
}

// 处理根路径 /
func homeHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	w.Write([]byte("<h1>Welcome to Go HTTP Server!</h1>"))
}

func main() {
	// 注册路由
	http.HandleFunc("/hello", helloHandler)
	http.HandleFunc("/", homeHandler)

	// 启动服务器
	fmt.Println("Server starting on http://localhost:8080")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Printf("Server failed to start: %v\n", err)
	}
}
