import Foundation
import SwiftUI


struct MyFoodLog: View {
    @Binding var foodLog: FoodLog
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Food Log").font(.title2).bold()
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(foodLog.foods) {
                    food in FoodDetail(food: food).padding(.top, 10).frame(maxWidth: .infinity, alignment: .leading)
                }
            }.frame(maxHeight: UIScreen.main.bounds.height * 0.4)
        }
    }
}

