import UIKit

// #嵌套类型
/*
 枚举通常被创建于支持类或者结构中的一些功能。对于一些复杂性的功能，我们可能需要嵌套的结构，swift支持在枚举、类、结构和类中使用嵌套类型。
 要写一个类型内的嵌套类型，我们只需要在类型的{}内，定义你的类型即可。
 */

// ## 行动中的嵌套类型
struct PokerCard {
    enum CardSuit: Character {
        case spades = "♠"
        case hearts = "♡"
        case diamonds = "♢"
        case clubs = "♣"
    }
    enum CardRank:Int {
        case two = 2,three,four,five,six,seven,eight,nine,ten,jack,queen,king,ace
        var value : String {
            switch self {
                case .jack:
                    return "J"
                case .queen:
                    return "Q"
                case .king:
                    return "K"
                case .ace:
                    return "A"
                default:
                    return "\(self.rawValue)"
            }
        }
    }
    
    let rank: CardRank
    let suit: CardSuit
    
    func desription()->String{
        return "\(suit.rawValue)\(rank.value)"
    }
}


let twoSpades = PokerCard(rank: .two, suit: .spades)
print(twoSpades.desription())

let aceSpades = PokerCard(rank: .ace, suit: .spades)
print(aceSpades.desription())

// ## 引用嵌套类型
// 外部引用嵌套类型，嵌套类型的类型名前加上其外部类型的类型名作为前缀
let rank = PokerCard.CardRank.ace
print(rank.value)
