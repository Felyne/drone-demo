package main

import (
	"fmt"
	"net/http"
	"time"

	"git.bmk.top/devops/cd-tool/common"
)

func main() {
	nums := []int{-1, 45, 0, 3}
	min := common.GetMin(nums)
	fmt.Println(min)

	http.HandleFunc("/", func(w http.ResponseWriter, req *http.Request) {
		t := time.Now().String()
		s := fmt.Sprintf("你好, 世界! -- Time: %s", t)
		fmt.Fprintf(w, "%v\n", s)

	})
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Println(err)
	}
}
