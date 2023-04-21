//
//  ExerciseForm.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/8/23.
//

import SwiftUI

struct ExerciseForm: View {
    @Binding var data: Exercise.FormData
    @EnvironmentObject var exerciseLoader: ExerciseLoader
    @State var searchText = ""
    @State var muscleSelection = "Name"
    var apiSelection = ["Name", "Muscle"]
    var body: some View {
        ScrollView{
            TextFieldWithLabel(label: "Name", text: $data.name, prompt: "Enter the name")
                .padding(.leading)
            
            TextFieldWithLabel(label: "Muscle", text: $data.muscle, prompt: "Enter a muscle")
                .padding(.leading)
            
            
            TextFieldWithLabel(label: "Search For Exercise", text: $searchText, prompt: "Search Name")
                .padding(.leading)
            
            Picker("API Search", selection: $muscleSelection) {
                ForEach(apiSelection, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.segmented)
            
            Button("Search") {
                Task {
                    
                    if muscleSelection == "Name" {
                        await exerciseLoader.loadExercisesByName(name: searchText)
                    } else {
                        await exerciseLoader.loadExercisesByMuscle(muscle: searchText)
                    }
                    
                }
                
            }
            
            
            Text("API Results Here")
                .padding()
            switch exerciseLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(let error): Text(error.localizedDescription)
            case .success(let apiResponse):
                ForEach(apiResponse, id: \.self) { exercise in
                    HStack {
                        Text(exercise.name)
                        Text(" : ")
                        Text(exercise.muscle)
                    }
                }
            }
            Text("Clicking 'add' will autofill exercise name and muscle with that api results info")
                .padding()
            
        }
        
    }
    
}

struct ExerciseForm_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseForm(data: Binding.constant(Workout.previewData[0].exercises[0].dataForForm)).environmentObject(ExerciseLoader(apiClient: ExerciseAPIService()))
    }
}
