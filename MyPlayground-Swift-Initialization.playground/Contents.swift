//: Playground - noun: a place where people can play

//Initialization

//1.Required Initializers
class SomeClass{
    required init(){
        
    }
}
/*not allowed
class SomesubClass: SomeClass{
    init(){
    
    }
}
 */

//2.Setting a Default Property Value with a Closure or Function
class SomeClass2{
    let someProperty: Int = {
        return 2
    }()
}

struct Chessboard{
    let  boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8{
            for j in 1...8{
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
    
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 1))