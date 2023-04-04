//
//  DataStore.swift
//  Fitness-Nutriton-App
//
//  Created by Nicki Lee on 3/29/23.
//

import Foundation
import SwiftUI

class DataStore: ObservableObject {
    @Published var userList: [User] = User.previewData
    @Published var foodLog: FoodLog = FoodLog.previewData
    
    func updateFoodLog(food: Food) {
        foodLog.foods.append(food)
    }
    
}
