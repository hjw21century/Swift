//: Playground - noun: a place where people can play

//Protocol Learning

//1.Protocol Syntax
/*
 protocol SomeProtocol{
    //protocol definition goes here
 }
 */

/*
 struct someStructure: FirstProtocol, AnotherProtocol{
    //structure definition goes here
 }
 */


/*
 class SomeClass: SomeSuperclass, FirstProtocol,AnotherProtocol{
    //class definition goes here
 }
 */

//2.Property Requirements
/*
protocol SomeProtocol{
    var mustBeSettable: Int{get set}
    var doesNotNeedToBeSettable: Int{get}
 }
 */

protocol AnotherProtocol{
    static var someTypeProperty: Int {get set}
}

protocol FullyNamed{
    var fullName: String{get}
}

struct Person: FullyNamed{
    var  fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed{

    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String{
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

//3.Method Requirements

protocol SomeProtocol{
    static func someTypeMethod()
}

protocol RandomNumberGenerator{
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator{
    var lastRandom = 42.0
    let m = 133999.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

//4.Mutating Method Requirements
protocol Togglable{
    mutating func toggle()
}

enum OnOffSwitch: Togglable{
    case off, on
    mutating func toggle() {
        switch self{
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch  = OnOffSwitch.off

lightSwitch.toggle()

//5.Initializer Requirements

protocol SomeProtocol2{
    init(someParameter: Int)
}

class SomeClass: SomeProtocol2{
    required init(someParameter: Int){
        //initializer implemention goes here
    }
}

protocol SomeProtocol3{
    init()
}

class SomeSuperClass{
    init(){
        //initializer implemention goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol3{
    required override init(){
    
        //initializer implemention goes here
    }
}

//6.PROTOCOLS as Types
class Dice{
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generrator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generrator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides) + 1)
    }
}

var d6 = Dice(sides: 6, generrator: LinearCongruentialGenerator())

for _ in 1...5{
    print("Random dice roll is \(d6.roll())")
}

//7.Delegation
protocol DiceGame{
    var dice: Dice{ get }
    func play()
}

protocol DiceGameDelegate{
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceroll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakeAndLadders: DiceGame{
    let finalSquare = 25
    let dice = Dice(sides:6, generrator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init(){
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11;
        board[09] = +09; board[10] = +02;
        board[14] = -10; board[19] = -11;
        board[22] = -02; board[24] = -08;
    }
    
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare{
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
}


class DiceGameTracker: DiceGameDelegate{
    var numberOfTurns = 0
    
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakeAndLadders{
            print("Started a new game of snakes and ladders")
        }
        
        print("The game is usong a \(game.dice.sides)-sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int){
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakeAndLadders()
game.delegate = tracker
game.play()

//8.Adding Protocol Conformance with an Extension
protocol TextResponsentable{
    var textualDescription: String{ get }
}

extension Dice: TextResponsentable{
    var textualDescription: String{
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12,generrator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakeAndLadders: TextResponsentable{
    var textualDescription: String{
        return "A game Snakes and Ladders with \(finalSquare)"
    }
}
print(game.textualDescription)

//9.Declaring Protocol Adoption with an Extension
struct Hamster{
    var name: String
    var textualDescription: String{
        return "A hamster name \(name)"
    }
}

extension Hamster: TextResponsentable{}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextReprentable: TextResponsentable = simonTheHamster
print(somethingTextReprentable.textualDescription)

//10.Collection of Protocol Types
