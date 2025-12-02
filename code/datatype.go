package main

import (
	"fmt"
	"time"
)

type Rectangle struct {
	Width  float64
	Height float64
}

// 计算面积的方法
func (r Rectangle) Area() float64 {
	return r.Width * r.Height
}

// 计算周长的方法
func (r Rectangle) Perimeter() float64 {
	return 2 * (r.Width + r.Height)
}

// 修改矩形尺寸的方法（指针接收者）
func (r *Rectangle) Scale(factor float64) {
	r.Width *= factor
	r.Height *= factor
}

func main() {
	var myBool bool = false
	fmt.Println("myBool:" + fmt.Sprintf("%t", myBool))

	var myInt int = 10
	fmt.Println("myInt:" + fmt.Sprintf("%d", myInt))

	var myFloat float32 = 10.1234567
	fmt.Println("myFloat:" + fmt.Sprintf("%f", myFloat))

	var myString string = "hello world"
	fmt.Println("myString:" + myString)

	// 0-255
	var myUint8 uint8 = 255
	fmt.Println("my uint8:" + fmt.Sprintf("%d", myUint8))
	// 0-65535
	var myUint16 uint16 = 65535
	fmt.Println("my uint16:" + fmt.Sprintf("%d", myUint16))
	// 0-4294967295
	var myUint32 uint32 = 4294967295
	fmt.Println("my uint32:" + fmt.Sprintf("%d", myUint32))
	// -128 - 127
	var myInt8 int8 = 127
	fmt.Println("my int8:" + fmt.Sprintf("%d", myInt8))
	// -32768 - 32767
	var myInt16 int16 = 32767
	fmt.Println("my int16:" + fmt.Sprintf("%d", myInt16))
	// -2147483648 - 2147483647
	var myInt32 int32 = 2147483647
	fmt.Println("my int32:" + fmt.Sprintf("%d", myInt32))
	// -9223372036854775808 - 9223372036854775807
	var myInt64 int64 = 9223372036854775807
	fmt.Println("my int64:" + fmt.Sprintf("%d", myInt64))

	// float32
	var myFloat32 float32 = 3.01234567890123456789
	fmt.Println("my float32:" + fmt.Sprintf("%f", myFloat32))
	// float64
	var myFloat64 float64 = 3.01234567890123456789
	fmt.Println("my float64:" + fmt.Sprintf("%f", myFloat64))

	var myByte byte = 255
	fmt.Println("my byte:" + fmt.Sprintf("%d", myByte))

	// 声明并初始化一个包含 3 个字符串的数组
	var fruits [3]string
	fruits[0] = "apple"
	fruits[1] = "banana"
	fruits[2] = "cherry"

	// 或者直接声明并初始化
	vegetables := [3]string{"carrot", "broccoli", "spinach"}

	// 使用 ... 自动推断长度
	colors := [...]string{"red", "green", "blue", "yellow"}

	fmt.Println("Fruits:", fruits)
	fmt.Println("Vegetables:", vegetables)
	fmt.Println("Colors:", colors)

	// 声明并初始化一个包含 5 个整数的数组
	var numbersArray1 [5]int
	numbersArray1[0] = 10
	numbersArray1[1] = 20
	numbersArray1[2] = 30
	numbersArray1[3] = 40
	numbersArray1[4] = 50

	// 或者直接声明并初始化
	scores := [4]int{85, 92, 78, 96}

	// 使用 ... 自动推断长度
	temperatures := [...]int{-5, 0, 15, 25, 30}

	fmt.Println("Numbers Array:", numbersArray1)
	fmt.Println("Scores:", scores)
	fmt.Println("Temperatures:", temperatures)

	// 遍历字符串数组
	names := [...]string{"Alice", "Bob", "Charlie"}
	fmt.Println("Names:")
	for i := 0; i < len(names); i++ {
		fmt.Printf("Index %d: %s\n", i, names[i])
	}

	// 使用 range 遍历数字数组
	numbersArray2 := [...]int{1, 2, 3, 4, 5}
	fmt.Println("\nNumbers Array :")
	for index, value := range numbersArray2 {
		fmt.Printf("Index %d: Value %d\n", index, value)
	}

	rect := Rectangle{Width: 10, Height: 5}

	fmt.Printf("矩形: %+v\n", rect)
	fmt.Printf("面积: %.2f\n", rect.Area())
	fmt.Printf("周长: %.2f\n", rect.Perimeter())

	// 使用指针方法修改矩形
	rect.Scale(2)
	fmt.Printf("缩放后矩形: %+v\n", rect)
	fmt.Printf("缩放后面积: %.2f\n", rect.Area())

	slice1 := []int{1, 2, 3, 4, 5}
	slice2 := slice1
	slice2[0] = 99
	fmt.Println(slice1)
	//超过容量会自动扩容
	slice2 = append(slice2, 6, 7, 8)
	fmt.Println(slice2)

	myMap := make(map[string]int)
	myMap["apple"] = 1
	myMap["banana"] = 2
	myMap["orange"] = 3
	fmt.Println(myMap)
	fmt.Println(myMap["orange"])
	//删除map元素
	delete(myMap, "apple")

	myMap["banana"] = 9

	for fruitName, fruitSeq := range myMap {
		fmt.Println("%s: %d", fruitName, fruitSeq)
	}

	myAge := 88
	point1 := &myAge
	fmt.Println("myAge=%d, *p=%d, p=%p ", myAge, *point1, point1)

	//==========1双向通道（默认）
	bidirCh := make(chan string)
	go func() {
		bidirCh <- "hello from bidir channel"
	}()

	fmt.Println("Bidir:", <-bidirCh)

	ch1 := make(chan int)
	//声明一个 “只能发送”的变量，指向它
	sendOnly := chan<- int(ch1)
	go func() {
		sendOnly <- 42
	}()

	fmt.Println("Send-only sent:", <-ch1)

	ch2 := make(chan bool)
	//声明一个“只能接收”的变量
	recvOnly := (<-chan bool)(ch2)
	go func() {
		//通过原通道发送(send-only 不能发 但ch2 可以)
		ch2 <- true
	}()

	myResult1 := <-recvOnly
	fmt.Println("Recv-only received:", myResult1)

	close(ch1)
	close(ch2)

	time.Sleep(100 * time.Millisecond)

}
