import Foundation
import SwiftUI

struct NutritionPage: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var user: User
    let frameW: Double = UIScreen.main.bounds.width * 0.9
    let frameH: Double = UIScreen.main.bounds.height * 0.9
    @State var isPresentingAddFoodForm: Bool = false
    @State var newFoodData = Food.FormData()
    
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 20)
            MyTDECalculator(user: user).padding()
            Spacer(minLength: 20)
            MyFoodLog(foodLog: $dataStore.foodLog)
            .sheet(isPresented: $isPresentingAddFoodForm) {
                NavigationStack {
                    AddFoodPage(data: $newFoodData)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Back") {
                                    isPresentingAddFoodForm.toggle()
                                    newFoodData = Food.FormData()
                                }
                            }
                        }
                }
            }
            Spacer(minLength: 20)
            Button("Add Food") {
                isPresentingAddFoodForm.toggle()
            }.buttonStyle(.borderedProminent).padding()
            Spacer(minLength: 20)
            MyCaloricIntake(
                foods: dataStore.foodLog.foods)
            .frame(width: frameW)
            Spacer(minLength: 40)
            Text("Calorie Surplus/Deficit: ***")
                .font(.title2).bold().padding().border(.black)
        }
        .frame(
            width: frameW,
            height: frameH,
            alignment: .top
        )
    }
}

struct NutritionPage_Previews: PreviewProvider {
    static var previews: some View {
        NutritionPage(user: Binding.constant(User.previewData[0]))
            .environmentObject(DataStore())
    }
}
