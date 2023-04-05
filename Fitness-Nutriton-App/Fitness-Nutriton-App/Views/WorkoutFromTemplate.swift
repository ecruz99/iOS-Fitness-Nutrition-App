//
//  WorkoutFromTemplate.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/3/23.
//

import SwiftUI

struct WorkoutFromTemplate: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var workout: Workout
    
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        VStack{
            Text(workout.name)
            Text(workout.startedAt.formatted(date: .abbreviated, time: .shortened))
            ForEach($workout.exercises){ $exercise in
                Text(exercise.name)
                ForEach(exercise.activities){activity in
                    HStack{
                        Text("Set: \(exercise.activities.firstIndex(where: {$0.id == activity.id})! + 1)")
                        Spacer()
                        Text("Weight: \(activity.weight)")
                        Spacer()
                        Text("Reps: \(activity.reps)")
                    }
                }
                
                
                
                Button("Add Set"){
                    exercise.activities.append(Activity(weight: 0, reps: 0))
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button("Cancel"){
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Finish Workout"){
                    dataStore.addWorkout(workout)
                }
            }
        }
    }
}

struct WorkoutFromTemplate_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutFromTemplate(workout: Workout.startWorkoutFromTemplate(from: WorkoutTemplate.previewData[0]))
        }
    }
}
