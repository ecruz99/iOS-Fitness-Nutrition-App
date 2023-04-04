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
    
    @Published var workouts: [Workout] = Workout.previewData
    
    func addWorkout(_ workout: Workout){
        workouts.append(workout)
    }
    
    //!!!!!!!!!!!
    //This wont work because the workout is not in workouts array when I'm trying to add an activity to an ongoing workout
    func addActivity(_ workout: Workout, _ exercise: Exercise){
        if let index = workouts.firstIndex(where: {$0.id == workout.id}){
            if let index2 = workouts[index].exercises.firstIndex(where: {$0.id == exercise.id}){
                workouts[index].exercises[index2].activities.append(Activity(weight: 0, reps: 0))
            }
        }
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
