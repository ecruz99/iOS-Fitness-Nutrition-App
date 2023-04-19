//
//  WorkoutFromTemplate.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/3/23.
//

import SwiftUI

struct CurrentWorkout: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var workout: Workout
    
    @EnvironmentObject var dataStore: DataStore
    
    @State var newExerciseFormData = Exercise.FormData()
    
    @State var presentingExercise: Bool = false
    
    @State var changeExercise: Bool = false
    
    @State var editExerciseFormData = Exercise.FormData()
    
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
                HStack{
                    Text("\(exercise.name) (\(exercise.muscle))")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Menu{
                        Button("Replace"){
                            changeExercise.toggle()
                        }
                        
                        Button("Delete", role: .destructive){
                            workout.deleteExercise(exercise)
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    
                }
                
                .sheet(isPresented: $changeExercise){
                    NavigationStack{
                        ExerciseForm(data: $editExerciseFormData)
                            .toolbar{
                                ToolbarItem(placement: .navigationBarLeading){
                                    Button("Cancel"){
                                        changeExercise = false
                                    }
                                }
                                ToolbarItem(placement: .navigationBarTrailing){
                                    Button("Replace"){
                                        let replacementExercise = Exercise.update(exercise, from: editExerciseFormData)
                                        exercise = replacementExercise
                                        changeExercise = false
                                    }
                                }
                            }
                    }
                }
                if exercise.activities.count>0{
                    
                    HStack{
                        Text("Set:")
                            .font(.title3)
                            .padding(.leading, 13)
                        Text("Weight:")
                            .font(.title3)
                            .padding(.leading, 32)
                        Text("Reps:")
                            .font(.title3)
                            .padding(.leading, 35)
                        Spacer()
                    }
                    
                    
                }
                ForEach($exercise.activities){$activity in
                    HStack{
                        Text("\(exercise.activities.firstIndex(where: {$0.id == activity.id})! + 1)")
                            .padding(5)
                            .frame(width: 30)
                            .background(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1.1))
                        Spacer()
                        if let bindingToWeight = Binding($activity.weight) {
                        
                                TextField("???", value: bindingToWeight, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(.center)
                                .frame(width: 60)
                                .accentColor(.green)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 2)
                                    .fill(.black))
                                .keyboardType(.numberPad)
                                    
                            
                        }
                        Spacer()
                        if let bindingToReps = Binding($activity.reps) {
                            
                            TextField("???", value: bindingToReps, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .multilineTextAlignment(.center)
                                .fixedSize()
                                .accentColor(.green)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 2)
                                    .fill(.black))
                                .keyboardType(.numberPad)
                                
                                
                                
                            
                        }
                        Spacer()
                        
                        Button(action:{activity.completed.toggle()}){
                            if activity.completed == false{
                                Image(systemName: "circle")
                                    .foregroundColor(.green)
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
                    .padding(.bottom)
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

struct CurrentWorkout_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CurrentWorkout(workout: Workout.startWorkoutFromTemplate(from: WorkoutTemplate.previewData[0]))
        }
    }
}
