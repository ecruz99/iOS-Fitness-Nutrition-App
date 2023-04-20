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
        
        ScrollView{
            TextFieldWithLabel(label: "Name", text: $data.name, prompt: "Enter the name")
                .padding(.leading)
            
            TextFieldWithLabel(label: "Muscle", text: $data.muscle, prompt: "Enter a muscle")
                .padding(.leading)
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
