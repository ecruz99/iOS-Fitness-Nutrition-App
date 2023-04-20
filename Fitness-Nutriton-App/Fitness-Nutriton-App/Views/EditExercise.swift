//
//  EditExercise.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/20/23.
//

import SwiftUI

struct EditExercise: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var data: Exercise.FormData
    @State var apiExercise: Bool = false
    @State var searchTerm: String = ""
    var body: some View {
        ScrollView {
            Spacer(minLength: 40)
            Text("Change Exercise").font(.title).bold().padding()
            HStack {
                Button("Change Exercise") {
                    apiExercise = false
                }.buttonStyle(.bordered).tint(apiExercise ? .gray : .blue)
                Button("Choose From List") {
                    apiExercise = true
                }.buttonStyle(.bordered).tint(apiExercise ? .blue : .gray)
            }.padding(.bottom, 20)
            if (apiExercise) {
                Text("API results here. All exercises displayed alphabetically, with a search bar at top to search by either name or muscle that filters the list. Clicking on exercise prompts user to 'add', user confirms")
            } else {
                ExerciseForm(data: $data)
            }
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.9)    }
}

struct EditExercise_Previews: PreviewProvider {
    static var previews: some View {
        EditExercise(data: Binding.constant(Exercise.FormData())).environmentObject(DataStore())
    }
}
