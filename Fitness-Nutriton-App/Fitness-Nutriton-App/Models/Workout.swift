
import Foundation


struct WorkoutTemplate: Identifiable{
    var id: UUID = UUID()
    var name: String
    var exercises: [ExerciseTemplate]
    
    struct FormData{
        var id: UUID = UUID()
        var name: String = ""
        var exercises: [ExerciseTemplate] = []
        
    }
    
    var dataForForm: FormData {
        FormData(
            name: name,
            exercises: exercises
        )
    }
    
    static func create(from formData: FormData) -> WorkoutTemplate {
        let workoutTemp = WorkoutTemplate(id: formData.id, name: formData.name, exercises: formData.exercises)
        return WorkoutTemplate.update(workoutTemp, from: formData)
    }
    
    static func update(_ workoutTemp: WorkoutTemplate, from formData: FormData) -> WorkoutTemplate {
        var workoutTemp = workoutTemp
        workoutTemp.name = formData.name
        return workoutTemp
    }
}

struct ExerciseTemplate: Identifiable{
    var id: UUID = UUID()
    var name: String
    var muscle: String
    
    struct FormData {
        var id: UUID = UUID()
        var name: String = ""
        var muscle: String = ""
    }
    
    var dataForForm: FormData {
        FormData(
            id: id,
            name: name,
            muscle: muscle
        )
    }
    
    static func create(from formData: FormData) -> ExerciseTemplate {
        ExerciseTemplate(id: formData.id, name: formData.name, muscle: formData.muscle)
    }
}


struct Workout: Identifiable{
    var id: UUID = UUID()
    var name: String
    var exercises: [Exercise]
    var startedAt: Date = Date.now
    
    static func reverseSort(_ workouts: [Workout]) -> [Workout]{
        return Array(workouts.sorted(by: {$0.startedAt > $1.startedAt}))
    }
}

struct Exercise: Identifiable{
    var id: UUID = UUID()
    var name: String
    var muscle: String
    var activities: [Activity] = []
    
    init(name: String, muscle: String, activities:[Activity]){
        self.name = name
        self.muscle = muscle
        self.activities = activities
    }
    
    init(template: ExerciseTemplate, activities: [Activity]) {
        self.name = template.name
        self.muscle = template.muscle
        self.activities = activities
    }
}


struct Activity: Identifiable{
    var id: UUID = UUID()
    var weight: Int
    var reps: Int
    var completed: Bool = false
}


extension Workout{
    static func startWorkoutFromTemplate(from template:WorkoutTemplate) -> Workout{
        let workout = Workout(name: template.name, exercises: template.exercises.map { Exercise.init(template: $0, activities: [])})
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

extension Workout{
    static let previewData = [
        Workout(name: "First Workout",
                exercises: [
                Exercise(name: "Bench Press", muscle: "Chest", activities: [Activity(weight: 100, reps: 10), Activity(weight: 100, reps: 10)]),
                Exercise(name: "Incline Press", muscle: "Chest", activities: [Activity(weight: 80, reps: 10)])],
               startedAt: Date(timeIntervalSinceReferenceDate: 223456789.0)),
        Workout(name: "Second Workout",
                exercises: [
                Exercise(name: "Squats", muscle: "Quads", activities: [Activity(weight: 100, reps: 10), Activity(weight: 100, reps: 10)])],
                startedAt: Date(timeIntervalSinceReferenceDate: 223556789.0)),
        Workout(name: "Third Workout",
                exercises: [
                Exercise(name: "Bicep Curls", muscle: "Bicep", activities: [Activity(weight: 25, reps: 10), Activity(weight: 30, reps: 10)]),
                Exercise(name: "Preacher Curls", muscle: "Bicep", activities: [Activity(weight: 60, reps: 10)])],
                startedAt: Date(timeIntervalSinceReferenceDate: 223856789.0)),
        Workout(name: "Fourth Workout",
                exercises: [
                Exercise(name: "Bench Press", muscle: "Chest", activities: [Activity(weight: 100, reps: 10), Activity(weight: 100, reps: 10)]),
                Exercise(name: "Incline Press", muscle: "Chest", activities: [Activity(weight: 80, reps: 10)])],
               startedAt: Date(timeIntervalSinceReferenceDate: 224856789.0))
    ]
}
