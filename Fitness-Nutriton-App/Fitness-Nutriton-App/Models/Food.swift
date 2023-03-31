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
    
    
    enum ServingSizeUnit: String {
        case g, oz, lb
    }
    
    
}
