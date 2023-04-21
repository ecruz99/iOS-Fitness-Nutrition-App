//
//  EditExerciseTemplate.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/20/23.
//

import SwiftUI

struct EditExerciseTemplate: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var data: ExerciseTemplate.FormData
    @State var apiExerciseTemplate: Bool = false
    @State var searchTerm: String = ""
    var body: some View {
        ScrollView {
            Spacer(minLength: 40)
            Text("Change Exercise").font(.title).bold().padding()
            HStack {
                Button("Change Exercise") {
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

struct EditExerciseTemplate_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseTemplate(data: Binding.constant(ExerciseTemplate.FormData())).environmentObject(DataStore())
    }
}
