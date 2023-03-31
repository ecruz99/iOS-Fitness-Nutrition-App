
import SwiftUI

struct TemplateDetails: View {
    let template: WorkoutTemplate
    
    @EnvironmentObject var dataStore: DataStore
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading){
            Text(template.name)
                .font(.title)
                .bold()
            ForEach(template.exercises){exercise in
                Text(exercise.name)
            }
            NavigationLink(destination: WorkoutTemplateView()){
                Button("Delete Template"){
                    dataStore.deleteTemplate(template)
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
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
