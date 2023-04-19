//
//  MainFitness.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 3/31/23.
//

import SwiftUI

struct MainFitness: View {
    let workout = Workout(name: "Change Me", exercises: [])
    var body: some View {
        ZStack{
            Rectangle().fill(Gradient(colors: [.white.opacity(0.6), .red.opacity(0.25)])).ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading){
                    Text("Main Fitness Page")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                        .padding(.leading, 10)
                    HStack{
                        NavigationLink(destination: CurrentWorkout(workout: Workout(name: "Change Me", exercises: []))){
                            Text("Begin New Workout")
                                .foregroundColor(.white)
                                .frame(width: 150, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue).shadow(radius: 3))
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                                .multilineTextAlignment(.center)
                        }
                        
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
                        .padding(.trailing, 10)
                        Text("View/edit templates or begin workout from a template")
                            .multilineTextAlignment(.center)
                            .padding(.trailing, 5)
                    }
                    .padding(.leading, 10)
                    .padding(.bottom, 40)
                    HStack{
                        NavigationLink(destination: WorkoutHistory()){
                            Text("Workout History")
                                .foregroundColor(.white)
                                .frame(width: 150, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange).shadow(radius: 3))
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                        }
                        Text("View your completed workouts")
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MainFitness_Previews: PreviewProvider {
    static var previews: some View {
        MainFitness()
    }
}
