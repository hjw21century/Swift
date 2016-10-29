//: Playground - noun: a place where people can play

//Error Handling

//1.Representing and Throwing Errors
enum VendingMachineError: Error{
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

throw
    VendingMachineError.insufficientFunds(coinsNeeded: 5)

//2.Handling Errors

//3.Propagating Errors Using Throwing Functions
func canThrowErrors() throws -> String{
    return "normal"
}

struct Item{
    var price: Int
    var count: Int
}

class VendingMachine{
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    func  vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited  else {
            throw
            VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispending \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws{
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack{
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

//4.Handling Erros Using Do-Catch
var vendingMachine2 = VendingMachine()
vendingMachine2.coinsDeposited = 8

do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine2)
} catch VendingMachineError.invalidSelection{
    print("Invalid Selection")
}catch VendingMachineError.outOfStock{
    print("Out of Stock.")
}catch VendingMachineError.insufficientFunds(let coinsNeeded){
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins")
}

//5.Converting Errors to Optional Values
/*
 func someThrowingFunction() throws -> Int{
    // ...
 }
 
 let x = try? someThrowingFunction()
 
 let y: Int?
 do{
    y = try someThrowingFunction()
 } catch{
    y = nil
 }

 */
//5.1Disabling Error Propagation
/*
let photo = try! loadImage(atPath: "Appleseed.jpg")
*/

//6.Specifying Cleanup Actions
/*
func processFile(filename: String) throws{
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        
        while let line = try file.readline(){
            //
        }
    }
}
 */
