package main

import (
	"fmt"
	"log"
	"net/http"
	"os/exec"
	"runtime"
)

func main() {
	// 创建一个文件服务器，用于提供静态文件
	fs := http.FileServer(http.Dir("./dist"))

	// 使用 http.StripPrefix 去掉 /dist 前缀
	http.Handle("/", http.StripPrefix("/", fs))

	// 启动 HTTP 服务器
	port := "8080"
	go func() {
		fmt.Printf("Server is running on http://localhost:%s\n", port)
		if err := http.ListenAndServe(":"+port, nil); err != nil {
			log.Fatal(err)
		}
	}()

	// 自动打开浏览器
	openBrowser("http://localhost:" + port)

	// 保持程序运行
	select {}
}

// 打开浏览器
func openBrowser(url string) {
	var err error
	switch runtime.GOOS {
	case "linux":
		err = exec.Command("xdg-open", url).Start()
	case "windows":
		err = exec.Command("rundll32", "url.dll,FileProtocolHandler", url).Start()
	case "darwin":
		err = exec.Command("open", url).Start()
	default:
		err = fmt.Errorf("unsupported platform")
	}
	if err != nil {
		log.Fatal(err)
	}
}
