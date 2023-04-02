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
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue).shadow(radius: 3))
                        .padding(.leading, 10)
                
                Text("Begin a workout with no template")
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, 40)
            
            HStack{
                NavigationLink(destination: WorkoutTemplates()){
                    Text("My Templates")
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.purple).shadow(radius: 3))
                }
                .padding(.trailing)
                Text("View/edit templates or begin workout from a template")
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 5)
            }
            .padding(.leading, 10)
            .padding(.bottom, 40)
            HStack{
                //This Text will eventually have navigationlink or sheet for a workout
                Text("Workout History")
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange).shadow(radius: 3))
                    .padding(.leading, 10)
                Text("View your completed workouts")
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
    }
}

struct MainFitness_Previews: PreviewProvider {
    static var previews: some View {
        MainFitness()
    }
}
