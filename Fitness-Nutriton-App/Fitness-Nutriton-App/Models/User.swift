import Foundation

struct User: Identifiable{
    var id: Int
    var age: Double
    var height: Double
    var weight: Double
    var sex: Sex
    
    var BMR:Double {
        if sex.rawValue == "male"{
            return 66.47+(6.24*weight)+(12.7*height)-(6.755*age)
        }
        else{
            return 655.1+(4.35*weight)+(4.7*height)-(4.7*age)
        }
    }
}
    
extension User{
    enum Sex: String{
        case male
        case female
    }
}


extension User{
    static let previewData = [
        User(id: 1, age: 23, height: 71, weight: 168, sex: .male),
        User(id: 2, age: 21, height: 64, weight: 130, sex: .female)]
}
