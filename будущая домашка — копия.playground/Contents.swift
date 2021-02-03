import UIKit
import Foundation
//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.

enum EngineState {
    case action
    case noAction
}
enum Windows {
    case openWindows
    case closeWindows
}

protocol Car {
    var model: String { get }
    var year: UInt { get }
    var engineState: EngineState { get set }
    var windows: Windows { get set}
    
    func printSpecificProperties()
}
extension Car {
    var old: UInt {
        get {
            let date = Date()
            let calendar = Calendar.current
            return UInt(calendar.component(.year, from: date)) - year
        }
    }
    mutating func changeEngineState(_ value: EngineState) {
        self.engineState = value
        print("change engineState at \(model) is \(engineState)")
    }
    mutating func changeWindows(_ value: Windows) {
        self.windows = value
        print("change windows at \(model) is \(windows)")
    }
}

enum SportBodyType {
    case citySportsCar
    case racingCar
}
class SportCar: CarCounter, Car {
    
    var model: String
    var year: UInt
    var engineState: EngineState
    var windows: Windows
    var sportBodyType: SportBodyType
    var sportsTiresIncluded: Bool
    
    init(model: String, year: UInt, sportsTiresIncluded: Bool, sportBodyType: SportBodyType) {
        self.model = model
        self.year = year
        self.engineState = .noAction
        self.windows = .closeWindows
        self.sportsTiresIncluded = sportsTiresIncluded
        self.sportBodyType = sportBodyType
        super.init()
    }

    func printSpecificProperties() {
        print("---------------")
        print("sportBodyType = \(sportBodyType)")
        print("sportsTiresIncluded = \(sportsTiresIncluded)")
        print("---------------")
    }
    func changeSportsTiresIncluded(_ value: Bool) {
       sportsTiresIncluded = value
       print("sportsTiresIncluded change is \(sportsTiresIncluded)")
   }
}
extension SportCar: CustomStringConvertible {
    var description: String {
        return "---------------\n model = \(model)\n sportBodyType = \(sportBodyType) \n year = \(year) \n old = \(old) \n sportsTiresIncluded = \(sportsTiresIncluded) \n engineState = \(engineState) \n windows = \(windows) \n---------------"
    }
}
    
enum Trailer {
    case trailer_Is_Attached
    case trailer_Is_Unpinned
}
enum SleepingPlace {
    case noSleepingPlace
    case oneBerth
    case twoBerth
}
class TrunkCar: CarCounter, Car {
    
    var model: String
    var year: UInt
    var engineState: EngineState
    var windows: Windows
    var trunkVolume: Double
    var sleepingPlace: SleepingPlace

    var trailer: Trailer {
        willSet {
            print("be careful the \(newValue)")
        }
    }
    var trunkIsOccupied: Double {
        didSet {
            let changeTrunkIsOccupied = trunkIsOccupied - oldValue
            print("change trunkIsOccupied at \(model) is \(changeTrunkIsOccupied), trunkIsOccupied = \(trunkIsOccupied)")
        }
    }
    init(model: String, year: UInt, trailer: Trailer, sleepingPlace: SleepingPlace, trunkVolume: Double) {
        self.model = model
        self.year = year
        self.engineState = .noAction
        self.windows = .closeWindows
        self.trailer = trailer
        self.sleepingPlace = sleepingPlace
        self.trunkVolume = trunkVolume
        self.trunkIsOccupied = 0.0
        super.init()
    }
    
    func printSpecificProperties() {
        print("---------------")
        print("sleepingPlace = \(sleepingPlace)")
        print("trailer = \(trailer)")
        print("trunkVolume = \(trunkVolume)")
        print("trunkIsOccupied = \(trunkIsOccupied)")
        print("---------------")
    }
    
    func changeTrunkIsOccupied(_ value: Double) {
        if (value + trunkIsOccupied) < 0 {
            print("only \(trunkIsOccupied) can be unloaded")
        } else if (value + trunkIsOccupied) <= trunkVolume {
           self.trunkIsOccupied = trunkIsOccupied + value
       } else {
           print("not enough storage for \(value), trunkIsOccupied no change = \(trunkIsOccupied)")
       }
   }
    func changeTrailer(_ value: Trailer) {
        trailer = value
        print("change trailer is \(trailer)")
    }
    func changeSleepingPlace(_ value: SleepingPlace) {
        sleepingPlace = value
        print("change sleepingPlace is \(sleepingPlace)")
    }
}
extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "---------------\n model = \(model)\n year = \(year) \n old = \(old) \n sleepingPlace = \(sleepingPlace) \n trailer = \(trailer) \n trunkVolume = \(trunkVolume) \n trunkIsOccupied = \(trunkIsOccupied) \n engineState = \(engineState) \n windows = \(windows) \n---------------"
    }
}

var sportCar1 = SportCar(model: "porche", year: 2017, sportsTiresIncluded: false, sportBodyType: .citySportsCar)
sportCar1.old
sportCar1.changeWindows(.openWindows)
sportCar1.changeEngineState(.action)
sportCar1.changeSportsTiresIncluded(true)
print(sportCar1)
sportCar1.printSpecificProperties()
CarCounter.carCounter

var trunkCar1: TrunkCar? = TrunkCar(model: "mann", year: 2009, trailer: .trailer_Is_Attached, sleepingPlace: .noSleepingPlace, trunkVolume: 300)
trunkCar1!.changeSleepingPlace(.twoBerth)
trunkCar1!.changeTrailer(.trailer_Is_Unpinned)
trunkCar1!.changeTrunkIsOccupied(70)
trunkCar1!.changeTrunkIsOccupied(500)
trunkCar1!.changeTrunkIsOccupied(-100)
print(trunkCar1!)
trunkCar1!.printSpecificProperties()
CarCounter.carCounter

trunkCar1 = nil
CarCounter.carCounter

class CarCounter {
    static var carCounter: Int = 0
    init() {
        CarCounter.carCounter += 1
    }
    deinit {
        CarCounter.carCounter -= 1
    }
}
