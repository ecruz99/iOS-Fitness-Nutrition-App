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
    @Published var foodTemplates: [Food] = Food.previewData
    var filteredFoodTemplates: [Food] = []
    
    @Published var workouts: [Workout] = Workout.previewData
    
    func addWorkout(_ workout: Workout){
        workouts.append(workout)
    }
    
    
    func updateFoodLog(food: Food) {
        foodLog.foods.append(food)
        
    }
    
    func updateFoodTemplates(food: Food) {
        foodTemplates.append(food)
    }
    
    func filterFoodTemplates(searchTerm: String) {
        let filteredList = foodTemplates.filter({$0.name.contains(searchTerm)})
        filteredFoodTemplates = filteredList
    }
    
    var filteredFoods: [Food] {
        get { filteredFoodTemplates }
        set { filteredFoodTemplates = [] }
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
    
    func updateExerciseTemplate(_ template: WorkoutTemplate, _ exercise:ExerciseTemplate){
        if let index = templates.firstIndex(where: {$0.id == template.id}){
            if let index2 = templates[index].exercises.firstIndex(where: {$0.id == exercise.id}){
                templates[index].exercises[index2] = exercise
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
