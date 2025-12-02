package main

import (
	"log"
)

func main() {
	log.Println("1. 这是普通日志 (log.Print)")
	log.Panic("3. 这是 Panic 日志")
	log.Fatal("2. 这是 Fatal 日志，程序将在此退出！")

	// 以下代码不会执行！
	log.Println("========1. 这是普通日志 (log.Print)")
	log.Println("========2. 这是普通日志 (log.Print)")
}
