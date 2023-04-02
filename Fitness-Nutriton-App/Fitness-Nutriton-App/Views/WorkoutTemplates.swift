import SwiftUI

struct WorkoutTemplates: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    @State var presentingWorkoutTemplate: Bool = false
    
    @State var newWorkoutTemplateFormData = WorkoutTemplate.FormData()
    
    var body: some View {
        VStack{
            Text("My Templates")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
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
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add New Template"){
                        presentingWorkoutTemplate.toggle()
                    }
                }
            }
        }
        .sheet(isPresented: $presentingWorkoutTemplate){
            NavigationStack{
                WorkoutTemplateForm(data: $newWorkoutTemplateFormData)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("Cancel"){
                                presentingWorkoutTemplate = false
                                newWorkoutTemplateFormData = WorkoutTemplate.FormData()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button("Save"){
                                let newWorkoutTemplate = WorkoutTemplate.create(from: newWorkoutTemplateFormData)
                                dataStore.addWorkoutTemplate(newWorkoutTemplate)
                                presentingWorkoutTemplate = false
                                newWorkoutTemplateFormData = WorkoutTemplate.FormData()
                            }
                        }
                    }
            }
        }
    }
}

struct WorkoutTemplates_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTemplates()
            .environmentObject(DataStore())
    }
}
