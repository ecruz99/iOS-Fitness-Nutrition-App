import SwiftUI

struct WorkoutTemplateView: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        NavigationStack{
            List(dataStore.templates) { template in
                NavigationLink(destination: TemplateDetails(template: template)){
                    VStack(alignment: .leading){
                        Text(template.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        ForEach(template.exercises){ exercise in
                            Text("\(exercise.name)  (\(exercise.muscle))")
                        }
                    }
                }
                
            }
            .navigationTitle("Templates")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add New Template"){
                        
                    }
                }
            }
        }
        
    }
}

struct WorkoutTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTemplateView()
            .environmentObject(DataStore())
    }
}
