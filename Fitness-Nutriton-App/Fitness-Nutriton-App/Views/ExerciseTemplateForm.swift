//
//  ExerciseTemplateForm.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/2/23.
//

import SwiftUI

struct ExerciseTemplateForm: View {
    @Binding var data: ExerciseTemplate.FormData
    
    var body: some View {
        VStack{
            Form{
                
                TextFieldWithLabel(label: "Name", text: $data.name, prompt: "Enter the name")
                
                TextFieldWithLabel(label: "Muscle", text: $data.muscle, prompt: "Enter a muscle")
                
            }
            .frame(maxHeight: 250)
            ScrollView{
                Text("Search Bar Here (2 search bars? one by exercise name, one by muscle group)")
                    .padding()
                Text("API Results Here")
                    .padding()
                Text("Clicking 'add' will autofill exercise name and muscle with that api results info")
                    .padding()
                Text("See what happens once this gets pushed up further into the form")
                    .padding()
                Text("See what happens once this gets pushed up further into the form")
                    .padding()
                Text("See what happens once this gets pushed up further into the form")
                    .padding()
                Text("See what happens once this gets pushed up further into the form")
                    .padding()
            }
        }
    }
}

struct TextFieldWithLabel: View {
    let label: String
    @Binding var text: String
    var prompt: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .bold()
                .font(.caption)
            TextField(label, text: $text, prompt: prompt != nil ? Text(prompt!) : nil)
                .padding(.bottom, 20)
        }
    }
}

struct ExerciseTemplateForm_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTemplateForm(data: Binding.constant(WorkoutTemplate.previewData[0].exercises[0].dataForForm))
    }
}
