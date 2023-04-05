import Foundation
import SwiftUI

struct SearchFoodForm: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var searchTerm: String
    @State var displaySearch: Bool = false
    
    var body: some View {
        ScrollView {
            TextField("Search", text: $searchTerm).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
            Button("Search") {
                Task {
                    if !searchTerm.isEmpty {
                        dataStore.filterFoodTemplates(searchTerm: searchTerm)
                        displaySearch = true;
                    } else {
                        print("Empty search")
                    }
                }
            }
            Spacer(minLength: 30)
            Text("Search Results").font(.title2).frame(maxWidth: .infinity, alignment: .leading)
            if (displaySearch) {
                MyFoodsSearchResults(
                    myFoodTemplates: dataStore.foodTemplates,
                    searchTerm: searchTerm)
            }
        }.frame(width: UIScreen.main.bounds.width * 0.9)
    }
    
    struct MyFoodsSearchResults: View {
        @EnvironmentObject var dataStore: DataStore
        var myFoodTemplates: [Food]
        var searchTerm: String
        
        var body: some View {
            NavigationStack {
                ForEach($dataStore.filteredFoods) { $food in
                    NavigationLink(
                        destination: NewFoodFromExisting(
                            data: $food.dataForForm,
                            food: food,
                            originalServingSize: food.servingSize)) {
                        FoodDetail(food: food).frame(alignment: .leading)
                    }
                }
            }.padding(10)
        }
    }
}

struct NewFoodFromExisting: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var data: Food.FormData
    @State var newServingSize: String = "0"
    @State var hasBeenAdded: Bool = false

    let food: Food
    let originalServingSize: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(data.name).font(.title).bold().padding(.bottom, 20)
            Text(String(format: "Macronutrients per %d%@", originalServingSize, data.servingSizeUnit.rawValue)).font(.headline).bold()
            VStack(alignment: .leading) {
                Text(String(format: "Calories: %@", data.calories))
                Text(String(format: "Protein: %@", data.protein))
                Text(String(format: "Fats: %@", data.fat))
                Text(String(format: "Carbs: %@", data.carbs))
            }.padding(.bottom, 30)
            HStack {
                Text("Serving Size").font(.headline)
                TextField("", text: $newServingSize).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
            }
            HStack {
                VStack(alignment: .center) {
                    Text("Calories").bold()
                    if food.calories != nil {
                        Text(newAmount(quant: food.calories!, num: Double(newServingSize) ?? 0, denom: originalServingSize))
                    }
                }
                VStack(alignment: .center) {
                    Text("Protein").bold()
                    if food.protein != nil {
                        Text(newAmount(quant: food.protein!, num: Double(newServingSize) ?? 0, denom: originalServingSize))                    }
                }
                VStack(alignment: .center) {
                    Text("Fat").bold()
                    if food.fat != nil {
                        Text(newAmount(quant: food.fat!, num: Double(newServingSize) ?? 0, denom: originalServingSize))                    }
                }
                VStack(alignment: .center) {
                    Text("Carbs").bold()
                    if food.carbs != nil {
                        Text(newAmount(quant: food.carbs!, num: Double(newServingSize) ?? 0, denom: originalServingSize))                    }
                }
            }.padding(.bottom, 30)
            Button(hasBeenAdded ? "Added!" : "Add Food To Daily Log") {
                Task {
                    if !newServingSize.isEmpty && !hasBeenAdded {
                        let newFood = Food.create(from: Food.FormData(
                            name: data.name,
                            servingSize: newServingSize,
                            servingSizeUnit: data.servingSizeUnit,
                            calories: newAmount(quant: food.calories ?? 0, num: Double(newServingSize) ?? 0, denom: originalServingSize),
                            protein: newAmount(quant: food.protein ?? 0, num: Double(newServingSize) ?? 0, denom: originalServingSize),
                            fat: newAmount(quant: food.fat ?? 0, num: Double(newServingSize) ?? 0, denom: originalServingSize),
                            carbs: newAmount(quant: food.carbs ?? 0, num: Double(newServingSize) ?? 0, denom: originalServingSize))
                        )
                        dataStore.updateFoodLog(food: newFood)
                        dataStore.updateFoodTemplates(food: newFood)
                        hasBeenAdded = true;
                    }
                }
            }.buttonStyle(.borderedProminent)
            Spacer(minLength: 40)
        }.frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: UIScreen.main.bounds.height * 0.8)
    }
}

func newAmount(quant: Int, num: Double, denom: Int) -> String {
    let result: Double = Double(quant) * (num / Double(denom))
    let newQuantity = Int(result.rounded(.toNearestOrAwayFromZero))
    return String(newQuantity)
}

struct SearchFoodForm_Previews: PreviewProvider {
    static var previews: some View {
        SearchFoodForm(searchTerm: Binding.constant("Orange")).environmentObject(DataStore())
    }
}


