import Foundation
import SwiftUI

struct SearchFoodForm: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var searchTerm: String
    @State var displaySearch: Bool = false
    @EnvironmentObject var foodLoader: FoodLoader
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TextField("Search", text: $searchTerm).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
                    Button("Search") {
                        Task {
                            await foodLoader.loadFood(food: searchTerm)
                            
                        }
                    }
                    
//                    Button("Search") {
//                        Task {
//                            if !searchTerm.isEmpty {
//                                dataStore.filterFoodTemplates(searchTerm: searchTerm)
//                                displaySearch = true;
//                            } else {
//                                print("Empty search")
//                            }
//                        }
//                    }
                    
                    Spacer(minLength: 30)
                    //Text("Search Results").font(.title2).frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    
                    if (displaySearch) {
                        MyFoodsSearchResults(
                            myFoodTemplates: dataStore.foodTemplates,
                            searchTerm: searchTerm)
                    }
                }.frame(width: UIScreen.main.bounds.width * 0.9)
                
                switch foodLoader.state {
                case .idle: Color.clear
                case .loading: ProgressView()
                case .failed(let error): Text(error.localizedDescription)
                case .success(let apiResponse):
                    HStack {
                        Text(apiResponse.parsed.first?.food.label ?? "Failure")
                        Text(" : ")
                        Text(String(apiResponse.parsed.first?.food.nutrients.ENERC_KCAL ?? 0.0))
                    }
                }
            }
        }
    }
    struct MyFoodsSearchResults: View {
        @EnvironmentObject var dataStore: DataStore
        var myFoodTemplates: [Food]
        var searchTerm: String
        
        var body: some View {
            VStack(alignment: .leading) {
                ForEach($dataStore.filteredFoods) { $food in
                    NavigationLink(
                        destination: NewFoodFromExisting(
                            data: $food.dataForForm,
                            food: food,
                            originalServingSize: food.servingSize)) {
                                FoodDetail(food: food)
                                    .frame(alignment: .leading).padding(.bottom, 8)
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
            Text(data.name).font(.title).bold().padding(.bottom, 15)
            Text(String(format: "Macronutrients per %d%@", originalServingSize, data.servingSizeUnit.rawValue)).font(.headline).bold()
            VStack(alignment: .leading) {
                Text(String(format: "Calories: %@", data.calories))
                Text(String(format: "Protein: %@", data.protein))
                Text(String(format: "Fats: %@", data.fat))
                Text(String(format: "Carbs: %@", data.carbs))
            }.padding(.bottom, 30)
            VStack(alignment: .center) {
                HStack {
                    Text("Serving Size").font(.headline)
                    TextField("", text: $newServingSize).textFieldStyle(RoundedBorderTextFieldStyle()).frame(maxWidth: UIScreen.main.bounds.width * 0.2, minHeight: 40)
                }.padding(.bottom, 20)
                HStack {
                    MacronutrientBox(nutrient: .calories, food: food, newSize: Double(newServingSize) ?? 0, originalSize: Double(originalServingSize))
                    MacronutrientBox(nutrient: .protein, food: food, newSize: Double(newServingSize) ?? 0, originalSize: Double(originalServingSize))
                    MacronutrientBox(nutrient: .fat, food: food, newSize: Double(newServingSize) ?? 0, originalSize: Double(originalServingSize))
                    MacronutrientBox(nutrient: .carbs, food: food, newSize: Double(newServingSize) ?? 0, originalSize: Double(originalServingSize))
                }.padding(.bottom, 30)
                Button(hasBeenAdded ? "Added!" : "Add Food To Daily Log") {
                    Task {
                        if !newServingSize.isEmpty && !hasBeenAdded {
                            let newFood = Food.create(from: Food.FormData(
                                name: data.name,
                                servingSize: newServingSize,
                                servingSizeUnit: data.servingSizeUnit,
                                calories: newAmount(quant: food.calories ?? 0, num: Double(newServingSize) ?? 0, denom: Double(originalServingSize)),
                                protein: newAmount(quant: food.protein ?? 0, num: Double(newServingSize) ?? 0, denom: Double(originalServingSize)),
                                fat: newAmount(quant: food.fat ?? 0, num: Double(newServingSize) ?? 0, denom: Double(originalServingSize)),
                                carbs: newAmount(quant: food.carbs ?? 0, num: Double(newServingSize) ?? 0, denom: Double(originalServingSize)))
                            )
                            dataStore.updateFoodLog(food: newFood)
                            dataStore.updateFoodTemplates(food: newFood)
                            hasBeenAdded = true;
                        }
                    }
                }.buttonStyle(.borderedProminent)
            }
            Spacer(minLength: 40)
        }.frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: UIScreen.main.bounds.height * 0.8)
    }
}

struct MacronutrientBox: View {
    let nutrient: Food.MacroNutrients
    let food: Food
    let newSize: Double
    let originalSize: Double
    
    var body: some View {
        VStack(alignment: .center) {
            Text(nutrient.rawValue).bold()
            switch nutrient {
            case .calories : Text(newAmount(quant: food.calories ?? 0, num: newSize, denom: originalSize))
            case .protein : Text(newAmount(quant: food.protein ?? 0, num: newSize, denom: originalSize))
            case .fat : Text(newAmount(quant: food.fat ?? 0, num: newSize, denom: originalSize))
            case .carbs : Text(newAmount(quant: food.carbs ?? 0, num: newSize, denom: originalSize))
            }
        }.frame(width: UIScreen.main.bounds.width * 0.2)
    }
}

func newAmount(quant: Int, num: Double, denom: Double) -> String {
    let result: Double = Double(quant) * (num / denom)
    let newQuantity = Int(result.rounded(.toNearestOrAwayFromZero))
    return String(newQuantity)
}

struct SearchFoodForm_Previews: PreviewProvider {
    static var previews: some View {
        SearchFoodForm(searchTerm: Binding.constant("Orange")).environmentObject(DataStore()).environmentObject(FoodLoader(apiClient: FoodAPIService()))
    }
}


