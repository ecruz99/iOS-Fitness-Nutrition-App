//
//  TemplateDetails.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 3/30/23.
//

import SwiftUI

struct TemplateDetails: View {
    let template: WorkoutTemplate
    var body: some View {
        VStack(alignment: .leading){
            Text(template.name)
                .font(.title)
                .bold()
            ForEach(template.exercises){exercise in
                Text(exercise.name)
            }
        }
        .toolbar{
            ToolbarItem(placement:.navigationBarTrailing){
                Button("Edit"){
                    
                }
            }
        }
    }
}

struct TemplateDetails_Previews: PreviewProvider {
    static var previews: some View {
        TemplateDetails(template: WorkoutTemplate.previewData[0])
    }
}
