//: Playground - noun: a place where people can play

//Generics

//1.The Problem That Generics Solve
func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoStrings(_ a: inout String, _ b: inout String){
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDouble(_ a: inout Double, _ b: inout Double){
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoValues<T>(_ a: inout T, _ b: inout T){
    let temporaryA = a
    a = b
    b = temporaryA
}

//2.Type Parameters
/*
Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).
 */

//3.Naming Type Parameters
/*
owever, when there isn’t a meaningful relationship between them, it’s traditional to name them using single letters such as T, U, and V
 */

//4.Generic Types
struct IntStack{
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    
    mutating func pop() -> Int{
        return items.removeLast()
    }
}

struct Stack<Element>{
    var items = [Element]()
    
    mutating func push(_ item: Element){
        items.append(item)
    }
    
    mutating func pop() -> Element{
        return items.removeLast()
    }
}

var stackOfString = Stack<String>()
stackOfString.push("uno")
stackOfString.push("dos")
stackOfString.push("tres")
stackOfString.push("cuatro")

//5.Extending a Generic Type
extension Stack{
    var topItem: Element?{
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfString.topItem{
    print("The top item on the stack is \(topItem).")
}
for i in 0...2 {
    stackOfString.pop()
}
if let topItem = stackOfString.topItem{
    print("The top item on the stack is \(topItem).")
}

//6.Type Constraints
//6.1.Type Constraint Syntax
/*
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U){
}
 */

//7.Type Constraints in Action
func findIndex(ofString valueToFind: String, in array: [String]) -> Int?{
    for (index, value) in array.enumerated() {
        if value == valueToFind{
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings){
    print("The index of llama is \(foundIndex)")
}

func findIndex2<T: Equatable>(of valueToFind: T, in array: [T]) -> Int?{
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let doubleIndex = findIndex2(of: 9.3, in: [3.14159, 0.1, 0.25])
let stringIndex = findIndex2(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])

//7.Associated Types
//7.1.Associated Types in Action
protocol Container{
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int {get}
    
    subscript(i: Int) -> ItemType {get}
}

struct IntStack2: Container{
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    
    mutating func pop() -> Int{
        return items.removeLast()
    }
    
    typealias  ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int{
        return items.count
    }
    
    subscript(i: Int) -> Int{
        return items[i]
        
    }
}
//7.2.Extending an Existing Type to Specify an Associated Type
/* for example
extension Array: Container{
 }
 */
 
//8.Where Clauses
func allItemsMatch<C1: Container, C2: Container>(
    _ someContainer: C1, _ anotherontainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable{
    if someContainer.count != anotherontainer.count{
        return false
    }
    
    for i in 0..<someContainer.count{
        if someContainer[i] != anotherontainer[i]{
            return false
        }
    }
    return true
}

/*
var stackOfStrings2 = Stack<String>()
stackOfStrings2.push("uno")
stackOfStrings2.push("dos")
stackOfStrings2.push("tres")

var arrayOfString = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings2, arrayOfString) {
    print("All items match.")
}else {
    print("Not All items match.")
}
 */
