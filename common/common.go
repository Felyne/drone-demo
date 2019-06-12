package common

import (
	"git.bmk.top/bmk/bmk-go-util/_int"
	"github.com/rs/xid"
)

func GetID() string {
	return xid.New().String()
}

func GetMin(nums []int) int {
	min, _ := _int.Min(nums)
	return min
}
