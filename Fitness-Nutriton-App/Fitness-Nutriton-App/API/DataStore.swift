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
    
    @Published var templates: [WorkoutTemplate] = WorkoutTemplate.previewData
    
    func deleteTemplate(_ template: WorkoutTemplate) {
      if let index = templates.firstIndex(where: { $0.id == template.id }) {
        templates.remove(at: index)
      }
    }
    
    
}
