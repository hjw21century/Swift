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
