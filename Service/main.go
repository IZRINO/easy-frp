package main

import (
	"embed"
	"flag"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/pkg/browser"
)

//go:embed dist/*
var dist embed.FS

func main() {
	// 从命令行接收端口参数
	var port string
	flag.StringVar(&port, "port", "9999", "HTTP服务器端口")
	flag.Usage = func() {
		log.Printf("使用方法 %s：\n", os.Args[0])
		flag.PrintDefaults()
	}
	flag.Parse()

	// 创建一个 Gin 路由器
	r := gin.Default()

	// 将嵌入的 dist 文件夹内容提供为静态文件服务
	r.StaticFS("/", http.FS(dist))

	// 获取本地IP地址
	ip, err := getLocalIP()
	if err != nil {
		log.Fatal(err)
	}

	// 启动 HTTP 服务器
	go func() {
		if err := r.Run(ip + ":" + port); err != nil {
			log.Fatal(err)
		}
	}()

	url := fmt.Sprintf("http://%s:%s", ip, port)

	// 自动打开浏览器
	openBrowser(url)

	// 保持程序运行
	select {}
}

// 获取本地IP地址
func getLocalIP() (string, error) {
	addrs, err := net.InterfaceAddrs()
	if err != nil {
		return "", err
	}
	for _, address := range addrs {
		// 检查ip地址判断是否回环地址
		if ipnet, ok := address.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
			if ipnet.IP.To4() != nil {
				return ipnet.IP.String(), nil
			}
		}
	}
	return "", fmt.Errorf("无法获取本地IP地址")
}

// 打开浏览器
func openBrowser(url string) {
	if err := browser.OpenURL(url); err != nil {
		log.Fatal(err)
	}
}
