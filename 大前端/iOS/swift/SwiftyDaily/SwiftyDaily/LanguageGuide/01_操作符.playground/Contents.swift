/*
 * 操作符号
 *
 */
// 一元操作符 unary operators
// example: -1 , !isBoy, optionString!

//二元操作符 binary operators
//example: +,-,*,/,%

//三元操作符 ternary
//example: ?:

//赋值操作符: =
let aResult = 10
var bResult = 5
bResult = aResult

let (a,b) = ("one","two")

//if bResult = aResult { //❌ 不允许
//
//}


// 算术运算符
//加法（addition）：+
//减（subtraction）: -
//乘（multiplication）: *
//除 （division）: /

//ps. 溢出操作符
//加法溢出操作符： &+
//减法溢出操作符： &-
//乘法溢出操作符： &*

//求余操作符(remainder operator) : a % b
let remainder = 9 % 4 // 1
let remander2 = 9 % -4  //same as remainder b 参数忽略 “-”号


//复试操作符 compound assignment operator : +=, -=
var compound = 10
compound += 1 // eq. compound = compound + 1  result 11
compound -= 2  // eq. compound = compund - 2 result 9


//比较操作符 comparision operators
//相等：a == b
//不相等： a != b
//大于：a > b
//小于：a < b
//大于等于： a >= b
//小于等于： a <= b
//id操作符： === , !== 比较两个对象是否相同
//元组比较：必须符合元组的类型相同，参数数量一致
let result1 = (1,"apple") < (1,"zebra") //从左到右比较，直到连个值不相等结束。取之前的值的结果
let result2 = (3,"apple") < (3,"bird")  //如果两个值是一样的，则会继续比较第二个参数。
let result3 = (3,"apple","cow") > (3,"apple","cat")


// 空合并运算符 ??
let result4 : String? = "a" //try nil
let result5  = result4 ?? "default"

//闭包范围运算符: ...
for index in 0...10{
    print("index1: \(index)")
}

//半闭包范围运算符: ..<
for index in 0..<10 {
    print("index2: \(index)")
}

//单边区间运算符:
// [a...] 从a索引到结尾
// [...a] 从0开始到下标a
// [..<a] 从0开始到下标a-1
let array1 = [1,2,3,4,5,6]
for value in array1[2...] {
    print("index3: \(value)")
}

for value in array1[...2] {
    print("index4: \(value)")
}

for value in array1[..<2] {
    print("index5: \(value)")
}

//逻辑运算符
//非：!a
//与: a && b
//或: a || b

//组合逻辑运算符：将多个逻辑运算符组合成一个

//括号：明确调整运算符优先级
