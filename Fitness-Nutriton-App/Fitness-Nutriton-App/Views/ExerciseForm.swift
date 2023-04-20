//
//  ExerciseForm.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/8/23.
//

import SwiftUI

struct ExerciseForm: View {
    @Binding var data: Exercise.FormData
    
    var body: some View {
        ScrollView{
            TextFieldWithLabel(label: "Name", text: $data.name, prompt: "Enter the name")
                .padding(.leading)
            
            TextFieldWithLabel(label: "Muscle", text: $data.muscle, prompt: "Enter a muscle")
                .padding(.leading)

        }
    }
}

struct ExerciseForm_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseForm(data: Binding.constant(Workout.previewData[0].exercises[0].dataForForm))
    }
}
