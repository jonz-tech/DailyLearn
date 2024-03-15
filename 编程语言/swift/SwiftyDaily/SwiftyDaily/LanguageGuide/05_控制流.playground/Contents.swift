/*
 * 控制流包括：
 * 1. 多次循环：while,for,for in
 * 2. 条件分支：if, guard,switch
 * 3. 跳转控制: break,continue
 */
import Foundation
//# for 循环控制：
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names { //枚举数组
    print("Hello, \(name)!")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs { //元组，枚举字典
    print("\(animalName)s have \(legCount) legs")
}

//数值区间表达： ...
for index in 1...5 {     //index >= 1  && index <= 5
    print("index1: \(index) times 5 is \(index * 5)")
}

//数值区间表达： ...
for index in 1..<5 {     //index >= 1  && index < 5
    print("index2: \(index) times 5 is \(index * 5)")
}

// 忽略index 则可用用 _ 代替
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}

//步长控制。 //tickMark >= 0  && tickMark < 60
let minuteInterval = 3
for tickMark in stride(from: 0, to: 60, by: minuteInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
    print("tickMark: \(tickMark)")
}


// # while 循环 可以不执行循环体
/*
 while condition {
    statements
 }
 */
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
    print("square is: \(square)")
}
print("Game over!")


//循环体 repeat-while  至少执行一次
/*
  repeat {
    statements
 } while condition
 */
square = 0
diceRoll = 0
repeat {
    // move up or down for a snake or ladder
    square += board[square]
    // roll the dice
    diceRoll += Int(arc4random())%6
    if diceRoll >= 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
    print("square2 is: \(square)")
} while square < finalSquare
print("Game over!")

// # if条件控制器
let temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}

// #switch 条件控制器
/*
 switch literaValue {
 case value1:
     respond to value 1
 case value2,
      value3:
     respond to value 2 or 3
 default:
     otherwise, do something else
 }
 */
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a","A": //合并表达式，用逗号隔开。这里与OC不同
    print("The letter A")
default:
    print("Not the letter A")
}


//间隔条件控制，不使用逗号隔开
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}

//元组判断
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}


//where 条件
let pt = (1,-1)
switch pt {
case let (x,y) where x == -y:
    print("\(x),\(y) is in x == -y ")
case let (x,y) where x == y:
    print("\(x),\(y) is in x == y ")
//case (x,y):
//    print("\(x),\(y) doing nothing ")
case (_, _): //这个条件是必须的
    print("doing nothing !")
}

//多条件分支，用逗号分开
let asomeCharacter: Character = "e"
switch asomeCharacter {
case "a", "e", "i", "o", "u":
    print("\(asomeCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(asomeCharacter) is a consonant")
default:
    print("\(asomeCharacter) isn't a vowel or a consonant")
}


//控制流转换。 continue \ break \ fallthrough \ return \ throw

//continue 跳出本次循环，开启下一轮循环
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)

//break 结束循环。 switch\for 循环体重可用
let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}
// Prints "The integer value of 三 is 3."

//fallthrough Swift 中的 switch 不会从上一个 case 分支落入到下一个 case 分支中。只要第一个匹配到的 case 分支完成了它需要执行的语句，整个switch代码块完成了它的执行. 要想它同时执行下一个case, 使用fallthrough
//一般switch语句中不使用fallthrough

var index = 10
switch index {
   case 100  :
      print( "index 的值为 100")
   case 10,15  :
      print( "index 的值为 10 或 15") //print index 的值为 10 或 15
   case 5  :
      print( "index 的值为 5")
   default :
      print( "默认 case")
}

switch index {
   case 100  :
      print( "index 的值为 100")
      fallthrough
   case 10,15  :
      print( "index 的值为 10 或 15") //print  index 的值为 10 或 15 && index 的值为 5
      fallthrough
   case 5  :
      print( "index 的值为 5")
   default :
      print( "默认 case")
}

//标签语句。
/*
 label name: while condition {
     statements
 }
 */
square = 0
diceRoll = 0
gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")

//提前退出 guard  和if一样，依赖条件结果。 guard必须有else流程。
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)!")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."

//检查api是否有效
/**
 if #available(platform name version, ..., *) {
     statements to execute if the APIs are available
 } else {
     fallback statements to execute if the APIs are unavailable
 }
 */
if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}

@available(macOS 10.12, *)
struct ColorPreference { //macos 10.12之后又这个
    var bestColor = "blue"
}

func chooseBestColor() -> String {
    guard #available(macOS 10.12, *) else { //非mac os 10.12及以上系统，返回gray.
        return "gray"
    }
    let colors = ColorPreference()
    return colors.bestColor
}
