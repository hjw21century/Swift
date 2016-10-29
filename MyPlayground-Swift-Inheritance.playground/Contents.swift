//Inheritance

//1.Defining a Base Class
class Vehicle{
    
    var currentSpeed = 0.0
    var description: String{
        return "travling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise(){
        
    }
}

//2.SubClassing
class Bicycle: Vehicle
{
    var hasBasket = false
}

//3.Overriding Methods
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

class Train: Vehicle{
    override func makeNoise() {
        print("Choo choo")
    }
}

//4.Overriding Properties
//4.1.Overriding Property Getters and Setters
class Car: Vehicle{
    var gear = 1
    override  var description: String{
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
//4.2.Overriding Property Observers
class AutomaticCar: Car{
    override var currentSpeed: Double{
        didSet{
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
//4.3.Preventing Overrides
final class AnotherCar: Car{
}

/* error will occur when compiling
 class TryACar: AnotherCar{
}
 */

//Initialization

//1.Setting Initial Values for Stored Properties
//1.1.Initializers
struct Fahrenheit{
    var temperature: Double
    init(){
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temprature is \(f.temperature)º Fahrenheit")
//1.2.Default Property Values
struct Fahrenheit2{
    var temperature = 32.0
}

//2.Customizing Initialization
//2.1.Initialization Parameters
struct Celsius{
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
//2.2.Parameter Names and Argument Labels
struct Color{
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 0.8)
let halfGray = Color(white: 0.5)
/* this reports a compile-time error
 let veryGreen = Color(0.0, 1.0, 0.0)
 */
//2.3.Initializer Parameters without Argument Labels
struct Celsius2{
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = Celsius2(37.0)
//2.4.Optional Property Types
class SurveyQuestion{
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask(){
        print(text)
    }
}
//2.5.Assigning Constant Properties During Inialization
class SurveyQuestion2{
    let text: String
    var response = String()
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets.(But not with cheese.)"

//3.Default Initializers
class ShoppingListItem{
    var name: String?
    var quantity = 1
    var purchase = false
}

var item = ShoppingListItem()
//3.1.Memberwise Initializers for Structure Types
struct Size{
    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 3.0)

//4.Initializer Delegation for Value Types
struct Size2{
    var width = 0.0, height = 0.0
}

struct Point2{
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point2()
    var size = Size2()
    init() {}
    init(origin: Point2, size: Size2) {
        self.origin = origin
        self.size = size
    }
    init(center: Point2, size: Size2) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point2(x: originX, y: originY), size: size)
    }
}

//5.Class Inheritnce and Initialization
//5.1.Designated Initializers and Convenience Initializers
//5.2.Syntax for Designated and Convenience Initializers
//5.3.Initializer Delegation for Class Types
/*
 Rule 1:A designated initializer must call a designated initializer from its immediate superclass.
 Rule 2:A convenience initializer must call another initializer from the same class.
 Rule 3:A convenience initializer must ultimately call a designated initializer.
 */

//6.Two-Phase Initialization
/*
 Safety check 1: A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
 Safety check 2: A designated initializer must delegatedd up to a superclass initializer before assigning a value to an inherited property.If it doesn't, the new value the designated initializer assingns will be overwritten by the superclass as part of its own initialization.
 Safety check 3: A convenience initializer must delegate to another initializer before assigning a value to any property(including properties defined by the same class).If it doesn't, the new value the conbvenience initializer assigns will be overwritten by its own class's designated initializer.
 Safety check 4: An initializer cannot call any instance method, read the value of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
*/
/*
 Phase 1:
 • A designated or convenience initializer is called on a class.
 • Memory for a new instance of that class is allocated.The memory is not yet initialized.
 • The designated initializer class confirms that all stored properties introduced by that class have a value.The memory for these stored properties is now initialized.
 • The desinated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
 • This continues up the class inheritance chain until the top of the chain is reahced.
 • Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance's memory is considered to be fully initialized, and the phase 1 is complete.
 
 Phase 2:
 • Working back down from the top of  the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
 •Finally, any convenience in itializers in the chain have the option to customize the instance and to work with self.
 */

//6.Initializer Inheritance and Overriding
class Vehicle2{
    var numberOfWheels = 0
    var description: String{
        return "\(numberOfWheels) wheel(s)"
    }
}

let vhicle = Vehicle2()
print("Vehicle: \(vhicle.description)")

class Bicycle2: Vehicle2{
    override init(){
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle2()
print("Bicycle: \(bicycle.description)")
//6.1.Automatic Initializer Inheritance
/*
 Rule 1: If your subclass doesn't define any designated initializers, it automatically inherites all of its superclass designated initializers.
 Rule 2: If your subclass provides an implementation of all of its superclass designated initializers--either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition--then it automatically inherits all of the super class convenice initializers.
 */

//7.Designated and Convenience Initializers in Action
class Food{
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init(){
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food{
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String){
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem2: RecipeIngredient{
    var purchased = false
    var description: String{
        var output = "\(quantity) x \(name)"
        output += purchased ? "✅" : "❎"
        return output
    }
}

var breakfastList = [
    ShoppingListItem2(),
    ShoppingListItem2(name: "Bacon"),
    ShoppingListItem2(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

//8.Failable Initializers
struct Animal{
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("an animal was initialized with a species of \(giraffe.species)")
}
let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creaturecould not be initalized")
}
