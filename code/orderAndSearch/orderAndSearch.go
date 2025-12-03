package main

import (
	"fmt"
	"math/rand"
	"sort"
	"time"
)

func main() {
	// 初始化随机种子
	rand.Seed(time.Now().UnixNano())

	// ========== 第一部分：排序 ==========
	fmt.Println("=== 排序部分 ===")
	nums1 := make([]int, 10)
	for i := 0; i < 10; i++ {
		nums1[i] = rand.Intn(100)
	}
	fmt.Printf("原始数组: %v\n", nums1)
	sort.Ints(nums1)
	fmt.Printf("排序后数组: %v\n\n", nums1)

	// ========== 第二部分：二分查找 ==========
	fmt.Println("=== 二分查找部分 ===")
	nums2 := make([]int, 20)
	for i := 0; i < 20; i++ {
		nums2[i] = rand.Intn(100)
	}
	sort.Ints(nums2)
	fmt.Printf("有序数组: %v\n", nums2)

	targetIndex := rand.Intn(20)
	target := nums2[targetIndex]
	fmt.Printf("随机选择的目标值: %d\n", target)

	// 新增：记录已查数字的切片
	var checkedNumbers []int

	round := 0
	left, right := 0, len(nums2)-1
	found := false
	foundIndex := -1

	for left <= right {
		round++
		mid := (left + right) / 2
		current := nums2[mid]

		// 将当前查找的数字加入已查列表
		checkedNumbers = append(checkedNumbers, current)

		// 输出格式：包含已查数字
		fmt.Printf("第 %d 轮: 查找数字 %d (索引=%d), 范围 [%d, %d], 已查数字: %v\n",
			round, current, mid, left, right, checkedNumbers)

		if current == target {
			found = true
			foundIndex = mid
			break
		} else if current < target {
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	if found {
		fmt.Printf("\n 查找成功！在第 %d 轮找到数字 %d，位于索引 %d\n",
			round, target, foundIndex)
	} else {
		fmt.Printf("\n 未找到目标值 %d\n", target)
	}
}
