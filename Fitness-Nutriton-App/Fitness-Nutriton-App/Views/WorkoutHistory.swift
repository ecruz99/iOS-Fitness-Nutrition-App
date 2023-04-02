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
                SingleWorkoutHistory(workout: workout)
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
