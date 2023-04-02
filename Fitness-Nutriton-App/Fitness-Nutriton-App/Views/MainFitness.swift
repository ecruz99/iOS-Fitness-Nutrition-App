//
//  MainFitness.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 3/31/23.
//

import SwiftUI

struct MainFitness: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Main Fitness Page")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 30)
                .padding(.bottom, 20)
                .padding(.leading, 10)
            HStack{
                //This Text will eventually have navigationlink or sheet for a workout
                Text("Begin New Workout")
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 4))
                    .padding(.leading, 10)
                Text("Begin a workout with no template")
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, 40)
            
            HStack{
                NavigationLink(destination: WorkoutTemplates()){
                    Text("My Templates")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.purple, lineWidth: 4))
                        .tint(.purple)
                }
                .padding(.trailing)
                Text("View/edit templates or begin workout from a template")
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 5)
            }
            .padding(.leading, 10)
            Spacer()
        }
    }
}

struct MainFitness_Previews: PreviewProvider {
    static var previews: some View {
        MainFitness()
    }
}
