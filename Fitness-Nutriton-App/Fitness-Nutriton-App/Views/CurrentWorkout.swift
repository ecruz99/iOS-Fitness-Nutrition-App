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
    
    @State var editingExercise: Exercise?
    
    @FocusState private var focusWeight: Bool
    @FocusState private var focusReps: Bool
    
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
                            editExerciseFormData = exercise.dataForForm
                            editingExercise = exercise
                            changeExercise.toggle()
                        }
                        
                        Button("Delete", role: .destructive){
                            workout.deleteExercise(exercise)
                        }
                    } label: {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    }
                    
                }
                
                if exercise.activities.count>0{
                    
                    HStack{
                        Text("Set:")
                            .font(.title3)
                            .padding(.leading, 13)
                        Text("Weight:")
                            .font(.title3)
                            .padding(.leading, 42)
                        Text("Reps:")
                            .font(.title3)
                            .padding(.leading, 44)
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
                        
                        
                        TextField("???", value: $activity.weight, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .frame(width: 60)
                            .accentColor(.black)
                            .focused($focusWeight)
                            .background(RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: focusWeight ? 4:2)
                                .fill(.blue))
                            .keyboardType(.numberPad)
                        
                        
                        
                        Spacer()
                        
                        
                        TextField("???", value: $activity.reps, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .frame(width: 50)
                            .accentColor(.black)
                            .focused($focusReps)
                            .background(RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: focusReps ? 4:2)
                                .fill(.yellow))
                            .keyboardType(.numberPad)
                        
                        
                        
                        
                        
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
                                if let editingExercise = editingExercise {
                                   let replacementExercise = Exercise.update(editingExercise, from: editExerciseFormData)
                                    workout.updateWorkout(replacementExercise)
                                    changeExercise = false
                                }
                            }
                        }
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
