import UIKit

// #类型角色 Type Casting
// Type Casting可以检测出实例是属于什么类型，或则判断类层级上是父类或者是子类。 类似OC的isKindClass:和isMemberClass:
// swift中实现方式:
//      1. is: 检测实例类型
//      2. as: 把实例扮演为其他不同类型
// 你也可以使用角色扮演来检测类型是否实现了协议

// #定义一个类层级的角色

// 基类：MediaItem
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

// 子类：Movie -> MediaItem
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

// 子类：Song -> MediaItem
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// 这里array会被swift推断为 [MediaItem] 类型。
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// 当你使用枚举获取数组对象时，拿到的会是MediaItem类型。你需要检测它实际类型并且转换为它实际的类型。

// #检测类型(is)
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")
// Prints "Media library contains 2 movies and 3 songs"

// #向下转化类型(as? 和as!)
/*
    由于转换类型有可能失败，所以它返回一个可选类型。你可以有两种确认方式：
 1. 不确定是否能转换成功(as?): 当你无法推断一个类型是否存在或者有可能返回nil的时候，使用as?
 2. 明确必然转换成功(as!): 当你能够安全保证转换成功，并且必然有返回值时，使用as!. as!是强制转换
 */

for item in library {
    if let movie = item as? Movie {
          print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
          print("Song: \(song.name), by \(song.artist)")
    }
}

// # Any和AnyObject类型的转换
/*
  swift提供了两个特殊的类型，来处理不确定类型
    1. AnyObject 可以代表任何class类型的实例
    2. Any 可以表示任意类型，甚至包括方法(func)类型
 
 // Any定义：所有类型隐式一致的协议
 public typealias Any = protocol<>
 
 // AnyObject定义：///所有类隐式一致的协议
 @objc public protocol AnyObject {
 
 }
 
 AnyObject是Any的子集
 所有用class关键字定义的对象就是AnyObject，也是Any类型
 所有不是用class关键字定义的对象都不是AnyObject，而是Any
 */

class PersonClass {
    var name : String
    init(_name: String){
        name = _name
    }
}
let jonz = PersonClass(_name: "jonz")
var personlist:[String: Any] = [:]
personlist["john"] = jonz

var objectList: [AnyObject] = []
objectList.append(jonz)

//例子2
var things: [Any] = []
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

let optionalNumber: Int? = 3
// things.append(optionalNumber)        // Warning
things.append(optionalNumber as Any) // No warning
