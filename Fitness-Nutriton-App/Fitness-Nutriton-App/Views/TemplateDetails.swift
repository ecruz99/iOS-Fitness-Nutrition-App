
import SwiftUI

struct TemplateDetails: View {
    let template: WorkoutTemplate
    
    @EnvironmentObject var dataStore: DataStore
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State var newExerciseTemplateFormData = ExerciseTemplate.FormData()
    
    @State var presentingExerciseTemplate: Bool = false
    
    @State var presentingWorkoutTemplate: Bool = false
    
    @State var editWorkoutTemplateFormData = WorkoutTemplate.FormData()
    
    var body: some View {
        ScrollView{
            HStack{
                Text(template.name)
                    .font(.title)
                    .bold()
                    .padding(.top, 40)

                Button("Edit name"){
                    editWorkoutTemplateFormData = template.dataForForm
                    presentingWorkoutTemplate.toggle()
                }
                .padding(.top, 45)
                .padding(.leading)
            }
            ForEach(template.exercises){exercise in
                Text("\(exercise.name)  (\(exercise.muscle))")
                    .font(.title3)
                    .padding(.top)
                    .padding(.bottom, 1)
                    .fontWeight(.semibold)
                NavigationLink(destination: TemplateDetails(template: template)){
                    Button("Delete Exercise"){
                        dataStore.deleteExerciseTemplate(template, exercise)
                    }
                    .tint(.red)
                }
                .padding(.bottom)
            }
            Button("Add Exercise"){
                presentingExerciseTemplate.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding(.bottom, 50)
            
            Text("Begin workout with this template")
                .foregroundColor(.white)
                .frame(width: 170, height: 50)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue).shadow(radius: 3))
                .padding(.bottom, 50)
                .multilineTextAlignment(.center)
            
            
            NavigationLink(destination: WorkoutTemplates()){
                Button("Delete Template"){
                    dataStore.deleteTemplate(template)
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            Spacer()
        }
        .sheet(isPresented: $presentingExerciseTemplate){
            NavigationStack{
                ExerciseTemplateForm(data: $newExerciseTemplateFormData)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("Cancel"){
                                presentingExerciseTemplate = false
                                newExerciseTemplateFormData = ExerciseTemplate.FormData()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button("Save"){
                                let newExerciseTemplate = ExerciseTemplate.create(from: newExerciseTemplateFormData)
                                dataStore.addExerciseTemplate(template, newExerciseTemplate)
                                presentingExerciseTemplate = false
                                newExerciseTemplateFormData = ExerciseTemplate.FormData()
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: $presentingWorkoutTemplate){
            NavigationStack{
                WorkoutTemplateForm(data: $editWorkoutTemplateFormData)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("Cancel"){
                                editWorkoutTemplateFormData = template.dataForForm
                                presentingWorkoutTemplate = false
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing){Button ("Save"){
                            let editedWorkoutTemplate = WorkoutTemplate.update(template, from: editWorkoutTemplateFormData)
                            dataStore.updateWorkoutTemplate(editedWorkoutTemplate)
                            presentingWorkoutTemplate.toggle()
                        }
                            
                        }
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
