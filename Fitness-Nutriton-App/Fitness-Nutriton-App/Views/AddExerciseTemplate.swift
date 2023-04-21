//
//  AddExerciseTemplate.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/20/23.
//

import SwiftUI

struct AddExerciseTemplate: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var data: ExerciseTemplate.FormData
    @State var apiExerciseTemplate: Bool = false
    @State var searchTerm: String = ""
    var body: some View {
        ScrollView {
            Spacer(minLength: 40)
            Text("Add Exercise").font(.title).bold().padding()
            HStack {
                Button("Create Exercise") {
                    apiExerciseTemplate = false
                }.buttonStyle(.bordered).tint(apiExerciseTemplate ? .gray : .blue)
                Button("Choose From List") {
                    apiExerciseTemplate = true
                }.buttonStyle(.bordered).tint(apiExerciseTemplate ? .blue : .gray)
            }.padding(.bottom, 20)
            if (apiExerciseTemplate) {
                Text("API results here. All exercises displayed alphabetically, with a search bar at top to search by either name or muscle that filters the list. Clicking on exercise prompts user to 'add', user confirms")
            } else {
                ExerciseTemplateForm(data: $data)
                    .padding(.top, 50)
            }
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.9)    }
}

struct AddExerciseTemplate_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseTemplate(data: Binding.constant(ExerciseTemplate.FormData())).environmentObject(DataStore())
    }
}
