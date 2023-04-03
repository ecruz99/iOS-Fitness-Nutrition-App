//created to fine tune and make the workout history view look better

import SwiftUI

struct SingleWorkoutHistory: View {
    let workout: Workout
    var body: some View {
        
        VStack(alignment: .leading){
            Text(workout.name)
                .padding(.bottom, 10)
                .font(.title2)
                .fontWeight(.semibold)
            HStack{
                Text("Date:")
                    .fontWeight(.semibold)
                Text("\(workout.startedAt.formatted(date: .abbreviated, time: .shortened))")
                
            }
            .padding(.bottom, 25)
            ForEach(workout.exercises){exercise in
                VStack(alignment: .leading){
                    HStack{
                        Text(exercise.name)
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding(.bottom, 0.5)
                        Text("(\(exercise.muscle))")
                            .font(.title3)
                    }
                    ForEach(exercise.activities){activity in
                        HStack{
                            Text("Set: \(exercise.activities.firstIndex(where: {$0.id == activity.id})! + 1)")
                            Spacer()
                            Text("Weight: \(activity.weight)")
                            Spacer()
                            Text("Reps: \(activity.reps)")
                        }
                    }
                }
                .padding(.bottom)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange.opacity(0.15)))
        .padding()
        
        
    }
}

struct SingleWorkoutHistory_Previews: PreviewProvider {
    static var previews: some View {
        SingleWorkoutHistory(workout: Workout.previewData[0])
    }
}
