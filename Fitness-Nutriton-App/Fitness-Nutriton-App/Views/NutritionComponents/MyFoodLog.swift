import Foundation
import SwiftUI


struct MyFoodLog: View {
    @Binding var foodLog: FoodLog
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Food Log").font(.title2).bold()
            ScrollView(.vertical, showsIndicators: true) {
                ForEach($foodLog.foods) {
                    $food in FoodDetail(food: $food).padding(.top, 10).frame(maxWidth: .infinity, alignment: .leading)
                }
            }.frame(maxHeight: UIScreen.main.bounds.height * 0.4)
        }
    }
}

struct FoodDetail: View {
    @Binding var food: Food
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let servingSize = food.servingSize {
                    Text(String(servingSize))
                    if let unit = food.servingSizeUnit {
                        Text(unit.rawValue)
                    }
                }
                Text(food.name)
            }.font(.body).bold()
            HStack {
                if let cal = food.calories {
                    Text(String(format: "Calories: %dg", cal))
                }
                if let pro = food.protein {
                    Text(String(format: "Protein: %dg", pro))
                }
                if let fat = food.fat {
                    Text(String(format: "Fat: %dg", fat))
                }
                if let carbs = food.carbs {
                    Text(String(format: "Carbs: %dg", carbs))
                }
            }.font(.system(size: 15))
        }
    }
}
