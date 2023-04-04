import Foundation
import SwiftUI

struct FoodLog: Identifiable {
    var id: Int
    var foods: [Food] = []
    
    static func addToLog(log: FoodLog, food: Food) -> FoodLog{
        var newLog = log
        newLog.foods.append(food)
        return newLog
    }
    
}

extension FoodLog {
    static let previewData: FoodLog = FoodLog(id: 1,foods: [Food(name: "Apple", calories: 95, protein: 1, carbs: 25),
                                                         Food(name: "Banana", calories: 110, protein: 1, fat: 0, carbs: 28)])
}
