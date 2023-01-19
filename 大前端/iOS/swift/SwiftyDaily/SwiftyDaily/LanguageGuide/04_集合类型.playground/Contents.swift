/*
 * 三种集合方式
 * 数组（array）: 有序集合
 * Set: 无需集合，且值不允许重复
 * 字典（dictionary）: 无需集合，用key-value存储
 */

//可变集合：var 变量名: 集合类型 = 集合值

//数组：array
let a:[Any] = [1,"a",true]      //简化声明格式. 逐个声明数组元素
let b:Array<Any> = [1,"a",true] //完整声明格式

let emptyConstInts:[Int]  = []
var emptyVarInts:[Int]  = []

let intDefault = Array(repeating: 0, count: 3) //Int类型数组。 初始化3个元素，且值默认为0
let doubleDefault = Array(repeating: 1.1, count: 3) //Double类型数组
let doubleDefault2 = Array(repeating: 0.0, count: 3) //Double类型数组
var combine = intDefault + a //将a替换成 doubleDefault 将会报错

//修改和访问数组方式
//1. 方法
//2. 属性
//3. 下标

//数组长度：.cout
print("combine array has \(combine.count) elements")
//判空: .isEmpty
print("1. emptyVarInts is empty ? \(emptyVarInts.isEmpty)")
//追加内容: .append(element)
//emptyVarInts[emptyVarInts.count] = "s" //❌ is not correct
emptyVarInts.append(99)
print("2. emptyVarInts is empty ? \(emptyVarInts.isEmpty)")
emptyVarInts += [3,4,5]
print("3. emptyVarInts is empty ? \(emptyVarInts.isEmpty)")
//访问数组元素
print("emptyVarInts 1 index element is: \(emptyVarInts[1])")
//元素插入
emptyVarInts.insert(1999, at: 3)
//元素移除
emptyVarInts.remove(at: 2)
//枚举元素
for element in emptyVarInts {
    print("\(element)")
}

for (index, element) in emptyVarInts.enumerated() { //枚举
    print("emptyVarInts[\(index)] is \(element)")
}


//Set集合
//对非重要数据，或者对数据唯一性有要求的，可以使用集合。
//集合要求存储的数据只能出现一次，这个比较依赖于哈希值
//对于swift, int,double,String,bool类型的数据都有哈希值
// Set不能被Swift推断出类型，所以必须用Set显式声明
//Set存储类型限制：Set<Type>
let letters : Set<Character> = ["1","2","3","a","b","A","a"] //这里两个a,也只被存储为了一个
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
//集合的访问和修改
//集合长度: .count
print("letters set has \(letters.count) charaters")
//判空：.isEmpty
print("letters set is empty ? \(letters.isEmpty) ")
//插入元素: .insert(element)
favoriteGenres.insert("x") //becase letters is declare as const type (let),so it can not use insert. try favoriteGenres
//移除元素:.remove(element)
favoriteGenres.remove(at: favoriteGenres.startIndex)
favoriteGenres.remove("Rock")
favoriteGenres.removeAll()
//包含元素：.contain(element)
letters.contains("A")
//枚举Set集合元素
for letter in letters {
    print("letter \(letter)")
}
//排序
for letter in letters.sorted() {
    print("letter1 \(letter)")
}
//set集合的数据处理
let pSet1: Set<String> = ["a","b","c","1","2","3","4","5","6","7","8","9","10"]
let pSet2: Set<String>  = ["a","A","C","2","4","6","8","10"]
//交集：seta.intersection(setb)
let intersection:Set<String> = pSet1.intersection(pSet2)
//差集：seta.symmetricDifference(setb) //去除两者重复部分
let symmetricDifference:Set<String> = pSet1.symmetricDifference(pSet2)
//合集：seta.union(setb) //合并两者元素，重复部分只保留一份
let union:Set<String> = pSet1.union(pSet2)

//集合间的关系
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
//相等：==
let equal = houseAnimals == farmAnimals
//包含：.isSubSet(of:)
let sontained = houseAnimals.isSubset(of: farmAnimals)
//不包含：.isDisjoint(with:)
let isDisjoint = farmAnimals.isDisjoint(with: cityAnimals)
//父集合：.isStrictSuperset()
let isStrictSuperset = farmAnimals.isStrictSuperset(of: houseAnimals)
//子集合：isStrictSubset
let isStrictSubset = houseAnimals.isStrictSubset(of: farmAnimals)


//字典：dictionary    [key1: value1, key2: value2, key3: value3]
var dictOfHostId = Dictionary<String, Int>() //常规初始化
var namesOfIntegers: [Int: String] = [:] //简化写法。 初始化一个空字典
var airports:[String:String] = ["白云机场":"GZ","大兴机场":"BJ","深圳机场":"SZ"] //枚举字典初始化
namesOfIntegers[16] = "sixteen"
//访问和修改字典
print("The namesOfIntegers dictionary contains \(namesOfIntegers.count) items.") //长度
let isEmpty = namesOfIntegers.isEmpty
//namesOfIntegers[3] = "London"
//更新value,若更新成功，会返回旧值。若没有，则插入值
if let oldValue = namesOfIntegers.updateValue("Dublin Airport", forKey: 3) {
    print("The old value for key 3 was  \(oldValue). update as \(namesOfIntegers[3] ?? "not exist")")
}else{
    print("namesOfIntegers not exist key 3  update as \(namesOfIntegers[3] ?? "not exist")")
}
print("print key 3 as: \(namesOfIntegers[3] ?? "index3 is empty") items.")

if let oldValue = namesOfIntegers.updateValue("Airport", forKey: 4) {
    print("The old value for DUB was \(oldValue).")
}

//默认值访问，返回可选类型。使用安全访问判断
if let key3Exit = namesOfIntegers[3] {
    print("key3 is exist value is \(key3Exit)")
}else{
    print("key3 is not exist")
}

//移除key-value
namesOfIntegers[3] = nil
namesOfIntegers.removeValue(forKey: 4)

//枚举字典
for (key,value) in namesOfIntegers {
    print("loop1: \(key) is \(value)")
}

for key in namesOfIntegers.keys {
    print("loop2: \(key) is \(namesOfIntegers[key]!)")
}

//key排序
namesOfIntegers[13] = "king"
namesOfIntegers[1] = "one"
namesOfIntegers[12] = "queen"
for key in namesOfIntegers.keys.sorted() {
    print("loop3: \(key) is \(namesOfIntegers[key]!)")
}
