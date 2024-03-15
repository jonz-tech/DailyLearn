/*
 * 字符串: String
 * 字符集: Character
 */

let someString = "this is a literal value" // 用 "" 括起来
let multilineString = """
this is line 1 \
this is line 2
this is line 3
""" //多行字符串 用三个 ”“” 括起来。 默认会在行后追加换行符，如果不想要换行符，可以在行末追加"\"

//字符串中的特殊字符集
//空字符: \055
let nullCharater = "this is a  \0"
//反斜线: \\
let blackslashCharater = "this is a blackslash \\a"
//水平制表符: \t
let horizontalTab = "this is a horizontal tab string \t"
//换行符: \n
let linefeed = "this is a line feed \n a"
//回车符: \r
let carriagereturn = "this is a carriage return \r a"
//双引符: \"
let doublequotation = "this is a double quatation mark \"book\""
//单引符: \'
let singlequotation = "this is a single quatation mark \'boo2\'"

//unicode字符: "\u{序号}"
let heart = "\u{2664}"
let heart2 = "\u{2665}"

let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""\
Escaping all three quotation marks \"""
"""

let delimiterString = #"Line 1\nLine 2"#
print("delimiterString.length: \(delimiterString.count)") //在字符串前后，使用##表示移除字符串中的转义

//空字符串:
let emptyString = ""
print("emptyString is empty \(emptyString.isEmpty)")

//可变字符串与不可变字符：
var mutatedString = "a"
mutatedString += "b" //ab

func addSpecialString(a:String){ //值类型数据是以let 形式表现
//    a = a + "bb" //无法进行改操作
}
class CC {
    var aString : String = ""
    func addSpecialString(a:String){ //值类型数据是以let 形式表现
//        a = a + "CC"
        aString = a + "bb" //无法进行改操作
    }
}

var cc = CC()
cc.addSpecialString(a: mutatedString)
print("\(cc.aString)")

addSpecialString(a: mutatedString)

let umutateString = "a"
//umutateString +="b" //error

//string 是一个值类型数据。这就意味着在赋值、函数、类方法中传递时，都是以“复制一份新数据”进行传递的形式进行。


//字符集: charators
let aCharator : Character = "Y" //字符长度为1
for letter in "hello,dog!" {
    print("\(letter)")
}
let transString = String(aCharator)


//字符串关联
// +
let lString = "hello,"
let rString = "swift"
var result = lString + rString

// +=
result += ". I m 5 year's old"

//.append()
result.append(contentsOf: ". do you like me ? ")
result.append(aCharator)


//多行关联
let begin = """
one
two

"""
let end = """

three

"""

var mResult = begin + end //空行被过滤

// 字符串插入 \()
let name = "objc" //Swift
let injectString = "I m \(name)"
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
let message2 = #"\#(multiplier) times 2.5 is \(Double(multiplier) * 2.5)""# //部分转义，不转义的在\()中间插入#

print(#"6 times 7 is \#(6 * 7)."#) //继续计算

// Unicode字符：21字节长度的字符集(拓展字符集群)
let a = "\u{61}"
let chick="\u{1F425}"

//字符长度计算：count()
var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in cafe is 4"

word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in café is 4"


//字符小标：.index()
//print("empty string begin:\(emptyString[emptyString.startIndex])") //越界
print("\(word)")
print("startIndex \(word.startIndex)")
print("endIndex \(word.endIndex)")
print("word begin: \(word[word.startIndex]) ")//开始
print("word end: \(word[word.index(before: word.endIndex)]) ") //结尾 befor: 只能用enindex. 原因：befor的startIndex前面没有值，会报错
print("word after startIndex: \(word[word.index(after: word.startIndex)]) ") //结尾 end 只能用starIndex。如果要用endIndex, 要用.index(_,offsetby) 原因：after的endIndex后面没有符号，会报错。如果要用starIndex, 要用.index(_,offsetby)

print("word after startIndex: \(word[word.index(word.startIndex,offsetBy: 0)]) ") //结尾
print("word after startIndex: \(word[word.index(word.endIndex,offsetBy: -1)]) ") //结尾


//插入字符
var welcome = "welcome "
welcome.insert("!", at: welcome.endIndex)
//welcome.insert(contentsOf: " wwdc2022", at: welcome.endIndex)
welcome.insert(contentsOf: " WWDC2022 ", at: welcome.index(before: welcome.endIndex))
print("\(welcome)")
//移除
//welcome.remove(at: welcome.endIndex) // ❌
//welcome.remove(at: welcome.index(before: welcome.endIndex))
//welcome.remove(at: welcome.index(welcome.endIndex,offsetBy: -1))
let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range) //移除一小段字符
print("\(welcome)")

//子字符串
let aLongString = "this is a long string # use to# split"
let index = aLongString.lastIndex(of: "#") ?? aLongString.endIndex
let splitString = aLongString[..<index]  //内存优化：子串直接复用部分母串的内存。
print("\(splitString)")
let newMemoryString = String(splitString) //这里会重新分配内存

//字符串比较
//字符比较：==, !=
let aCompareString = "this is a long string # use to# split"
if aLongString == aCompareString {
    print("aLongString is eq to aCompareString")
}else {
    print("aLongString is  not eq to aCompareString")
}

// "café?" using LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "caf\u{E9}?"

// "café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal") // Prints "These two strings are considered equal"
}


let latinCapitalLetterA: Character = "\u{41}" //拉丁字母 A
 
let cyrillicCapitalLetterA: Character = "\u{0410}" //西里尔字母A

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters aren't equivalent.")
}

//开头和结尾匹配：hasPrefix(),hasSuffix
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
let prefix = "Act 2"
let suffix = "cell"
for astring in romeoAndJuliet {
    if astring.hasPrefix(prefix) {
        print("\(astring) hasprefix \(prefix)")
    }
    
    if astring.hasSuffix(suffix) {
        print("\(astring) hasSuffix \(suffix)")
    }
    
}

//unicode字符单元
let codeString = "🐴"
print("\(codeString) count: \(codeString.count)")

print("===== utf8 Representation ======")

for unit in codeString.utf8 {
    print("\(unit)")
}

print("===== utf16 Representation ======")
for unit in codeString.utf16 {
    print("\(unit)")
}

print("===== unicodeScalars Representation ======")
for scalar in codeString.unicodeScalars {
    print("\(scalar) ")
}
