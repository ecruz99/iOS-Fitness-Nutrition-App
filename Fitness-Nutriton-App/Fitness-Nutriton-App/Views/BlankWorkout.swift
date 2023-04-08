//
//  BlankWorkout.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/8/23.
//

import SwiftUI

struct BlankWorkout: View {
    @State var workout = Workout(name: "Change Me!", exercises: [])
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        ScrollView{
            Text(workout.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.red)
            Text(workout.startedAt.formatted(date: .abbreviated, time: .shortened))
                .padding(.bottom)
            ForEach($workout.exercises){ $exercise in
                Text("\(exercise.name) (\(exercise.muscle))")
                    .font(.title2)
                    .fontWeight(.semibold)
                ForEach($exercise.activities){$activity in
                    HStack{
                        Text("Set: \(exercise.activities.firstIndex(where: {$0.id == activity.id})! + 1)")
                        Spacer()
                        if let bindingToWeight = Binding($activity.weight) {
                            HStack{
                                Text("Weight:")
                                TextField("???", value: bindingToWeight, formatter: NumberFormatter())
                                    .padding(2)
                                    .border(.green)
                                    .fixedSize()
                            }
                        }
                        Spacer()
                        if let bindingToReps = Binding($activity.reps) {
                            HStack{
                                Text("Reps:")
                                TextField("???", value: bindingToReps, formatter: NumberFormatter())
                                    .border(.blue)
                                    .fixedSize()
                            }
                        }
                        Spacer()
                        Button(action:{activity.completed.toggle()}){
                            if activity.completed == false{
                                Image(systemName: "circle")
                                    .foregroundColor(.red)
                            }else{
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        Spacer()
                        Button(action: {exercise.deleteActivity(activity)}){
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                
                
                
                Button("Add Set"){
                    exercise.activities.append(Activity(weight: 0, reps: 0))
                }
                .padding(.bottom, 20)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button("Cancel"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Finish Workout"){
                    dataStore.addWorkout(workout)
                    dismiss()
                }
            }
        }
    }
}

struct BlankWorkout_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BlankWorkout()
        }
    }
}
