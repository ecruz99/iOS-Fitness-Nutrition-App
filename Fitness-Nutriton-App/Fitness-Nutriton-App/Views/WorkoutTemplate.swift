import SwiftUI

struct WorkoutTemplateView: View {
    let templates = WorkoutTemplate.previewData
    
    var body: some View {
        NavigationStack{
            ForEach(templates) { template in
                VStack(alignment: .leading){
                    Text("Template: \(template.name)")
                        .bold()
                    ForEach(template.exercises){ exercise in
                        Text(exercise.name)
                    }
                    Spacer()
                }
            }
            .navigationTitle("Templates")
        }
    }
}

struct WorkoutTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTemplateView()
    }
}
