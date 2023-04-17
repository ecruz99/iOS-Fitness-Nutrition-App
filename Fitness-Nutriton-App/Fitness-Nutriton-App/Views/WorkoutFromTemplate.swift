//
//  WorkoutFromTemplate.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/3/23.
//

import SwiftUI

struct WorkoutFromTemplate: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var workout: Workout
    
    @EnvironmentObject var dataStore: DataStore
    
    @State var newExerciseFormData = Exercise.FormData()
    
    @State var presentingExercise: Bool = false
    
    var body: some View {
        ScrollView{
            TextField("Name", text: $workout.name)
                .padding(8)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.15)).shadow(radius: 3))
                .fixedSize()
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
                                    .background(RoundedRectangle(cornerRadius: 0).fill(Color.gray.opacity(0.15)).shadow(radius: 3))
                                    .border(.cyan)
                                    .fixedSize()
                                    .keyboardType(.numberPad)
                                    
                            }
                        }
                        Spacer()
                        if let bindingToReps = Binding($activity.reps) {
                            HStack{
                                Text("Reps:")
                                TextField("???", value: bindingToReps, formatter: NumberFormatter())
                                    .padding(2)
                                    .background(RoundedRectangle(cornerRadius: 0).fill(Color.gray.opacity(0.15)).shadow(radius: 3))
                                    .border(.black)
                                    .fixedSize()
                                    .keyboardType(.numberPad)
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
            
            Button("Add Exercise"){
                presentingExercise.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding(.bottom, 50)
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
        .sheet(isPresented: $presentingExercise){
            NavigationStack{
                ExerciseForm(data: $newExerciseFormData)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("Cancel"){
                                presentingExercise = false
                                newExerciseFormData = Exercise.FormData()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button("Save"){
                                let newExercise = Exercise.create(from: newExerciseFormData)
                                workout.addExercise(newExercise)
                                presentingExercise = false
                                newExerciseFormData = Exercise.FormData()
                            }
                        }
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
