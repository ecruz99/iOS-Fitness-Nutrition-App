import Foundation
import SwiftUI

struct Food: Identifiable {
    var id: UUID = UUID()
    var name: String
    var servingSize: Int?
    var servingSizeUnit: ServingSizeUnit?
    var calories: Int?
    var protein: Int?
    var fat: Int?
    var carbs: Int?
    
    
    enum ServingSizeUnit: String, CaseIterable, Identifiable {
        var id: Self { self }
        case g, oz, lb
    }
    
    enum MacroNutrients: String {
        case calories, protein, fat, carbs
    }
    
    struct FormData {
        var name: String = ""
        var servingSize: String = ""
        var servingSizeUnit: ServingSizeUnit = ServingSizeUnit.g
        var calories: String = ""
        var protein: String = ""
        var fat: String = ""
        var carbs: String = ""
    }

    var dataForForm: FormData {
      FormData(
        name: name,
        servingSize: servingSize != nil ? String(servingSize!) : "",
        servingSizeUnit: servingSizeUnit ?? ServingSizeUnit.g,
        calories: calories != nil ? String(calories!) : "",
        protein: protein != nil ? String(protein!) : "",
        fat: fat != nil ? String(fat!) : "",
        carbs: carbs != nil ? String(carbs!) : ""
      )
    }

    static func create(from formData: FormData) -> Food {
        Food(
            name: formData.name,
            servingSize: formData.servingSize.filter{"0123456789".contains($0)}.isEmpty ? nil : Int(formData.servingSize),
            servingSizeUnit: formData.servingSizeUnit,
            calories: formData.calories.filter{"0123456789".contains($0)}.isEmpty ? nil : Int(formData.calories),
            protein: formData.protein.filter{"0123456789".contains($0)}.isEmpty ? nil : Int(formData.protein),
            fat: formData.fat.filter{"0123456789".contains($0)}.isEmpty ? nil : Int(formData.fat),
            carbs: formData.carbs.filter{"0123456789".contains($0)}.isEmpty ? nil : Int(formData.carbs))
    }
    
    
}
