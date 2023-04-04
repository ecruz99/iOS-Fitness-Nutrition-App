import Foundation
import SwiftUI

struct NewFoodForm: View {
    @Binding var data: Food.FormData
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 40)
            Text("New Food Form").font(.title).bold().padding()
            HStack {
                Text("Food Name").font(.headline)
                TextField("", text: $data.name).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
            }
            Spacer(minLength: 40)
            HStack {
                Group {
                    Text("Serving Size").font(.headline)
                    TextField("", text: $data.servingSize).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
                }
                Group {
                    Text("Unit").font(.headline)
                    Picker(selection: $data.servingSizeUnit, label: Text("Unit")) {
                        ForEach(Food.ServingSizeUnit.allCases) {
                            unit in Text(unit.rawValue)
                        }
                    }
                }
            }
            Spacer(minLength: 40)
            HStack {
                VStack(alignment: .center) {
                    Text("Calories").font(.headline)
                    TextField("", text: $data.calories).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
                }
                VStack(alignment: .center) {
                    Text("Protein").font(.headline)
                    TextField("", text: $data.protein).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
                }
                VStack(alignment: .center) {
                    Text("Fat").font(.headline)
                    TextField("", text: $data.fat).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
                }
                VStack(alignment: .center) {
                    Text("Carbs").font(.headline)
                    TextField("", text: $data.carbs).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
                }
            }
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.9)
    }
}


