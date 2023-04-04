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
    @Published var templates: [WorkoutTemplate] = WorkoutTemplate.previewData
    
    func updateFoodLog(food: Food) {
        foodLog.foods.append(food)
    }
    
    func deleteTemplate(_ template: WorkoutTemplate) {
      if let index = templates.firstIndex(where: { $0.id == template.id }) {
        templates.remove(at: index)
      }
    }
    
    func deleteExerciseTemplate(_ template: WorkoutTemplate, _ exercise:ExerciseTemplate){
        if let index = templates.firstIndex(where: {$0.id == template.id}){
            if let index2 = templates[index].exercises.firstIndex(where: {$0.id == exercise.id}){
                templates[index].exercises.remove(at: index2)
            }
        }
    }
    
    func addExerciseTemplate (_ template: WorkoutTemplate, _ exercise: ExerciseTemplate){
        if let index = templates.firstIndex(where: {$0.id == template.id}){
            templates[index].exercises.append(exercise)
        }
    }
    
    func addWorkoutTemplate(_ template: WorkoutTemplate){
        templates.append(template)
    }
    
    func updateWorkoutTemplate(_ template: WorkoutTemplate){
        if let index = templates.firstIndex(where: {$0.id == template.id} ) {
            templates[index] = template
        }
    }
}
