
import Foundation


struct WorkoutTemplate: Identifiable{
    var id: UUID = UUID()
    var name: String
    var exercises: [ExerciseTemplate]
}

struct ExerciseTemplate: Identifiable{
    var id: UUID = UUID()
    var name: String
    var muscle: String
}


struct Workout{
    var name: String
    var exercises: [Exercise]
    var startedAt: Date = Date.now
}

struct Exercise{
    var name: String
    var muscle: String
    var activities: [Activity] = []
    
    init(template: ExerciseTemplate) {
        self.name = template.name
        self.muscle = template.muscle
    }
}


struct Activity{
    var weight: Int
    var reps: Int
    var completed: Bool = false
}


extension Workout{
    static func startWorkoutFromTemplate(from template:WorkoutTemplate) -> Workout{
        let workout = Workout(name: template.name, exercises: template.exercises.map { Exercise.init(template: $0)})
        return workout
    }
}

//new workout (w/o temp) dont make an empty temp for that. Just create a Workout Struct

extension WorkoutTemplate{
    static let previewData = [
        WorkoutTemplate(name: "Push Day",
        exercises: [ExerciseTemplate(name: "Bench Press", muscle: "Chest"),
                    ExerciseTemplate(name: "Incline Press", muscle: "Chest"),
                    ExerciseTemplate(name: "Skull Crushers", muscle: "Tricep")]),
                              
        WorkoutTemplate(name: "Pull Day",
        exercises: [ExerciseTemplate(name: "Cable Row", muscle: "Mid Back"),
                    ExerciseTemplate(name: "Pull Ups", muscle: "Back"),
                    ExerciseTemplate(name: "Bicep Curls", muscle: "Bicep")]),
    
        WorkoutTemplate(name: "Leg Day",
        exercises: [ExerciseTemplate(name: "Squat", muscle: "Quads"),
                    ExerciseTemplate(name: "Leg Curl", muscle: "Hamstrings"),
                    ExerciseTemplate(name: "Leg Extensions", muscle: "Quads")])]

}

