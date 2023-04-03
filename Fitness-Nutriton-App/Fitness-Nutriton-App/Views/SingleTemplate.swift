//
//  SingleTemplate.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 4/3/23.
//

import SwiftUI

struct SingleTemplate: View {
    let template: WorkoutTemplate
    
    var body: some View {
        
        
        NavigationLink(destination: TemplateDetails(template: template)){
            VStack(alignment: .leading){
                Text(template.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                    .foregroundColor(.black)
                ForEach(template.exercises){ exercise in
                    Text("\(exercise.name)  (\(exercise.muscle))")
                        .padding(.bottom, 1)
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.purple.opacity(0.35)))
            .padding()
        }
        
    }
    
}

struct SingleTemplate_Previews: PreviewProvider {
    static var previews: some View {
        SingleTemplate(template: WorkoutTemplate.previewData[0])
    }
}
