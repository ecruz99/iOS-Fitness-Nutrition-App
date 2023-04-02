//
//  WorkoutHistory.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/2/23.
//

import SwiftUI

struct WorkoutHistory: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        ScrollView{
            Text("Workout History")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
            ForEach(Workout.reverseSort(dataStore.workouts)) { workout in
                VStack(alignment: .leading){
                    Text(workout.name)
                        .padding(.bottom, 1)
                        .font(.title2)
                        .fontWeight(.semibold)
                    HStack{
                        Text("Date:")
                            .fontWeight(.semibold)
                        Text("\(workout.startedAt.formatted(date: .abbreviated, time: .shortened))")

                    }
                    .padding(.bottom, 2)
                    ForEach(workout.exercises){exercise in
                        VStack(alignment: .leading){
                            Text(exercise.name)
                                .font(.title3)
                            ForEach(exercise.activities){activity in
                                HStack{
                                    Text("Set: \(exercise.activities.firstIndex(where: {$0.id == activity.id})! + 1)")
                                    Text("Weight: \(activity.weight)")
                                    Text("Reps: \(activity.reps)")
                                }
                            }
                        }
                        .padding(.bottom)
                    }
                    
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2))
                
            }
        }
    }
}

struct WorkoutHistory_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHistory()
            .environmentObject(DataStore())
    }
}
