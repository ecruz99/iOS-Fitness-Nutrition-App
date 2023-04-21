//
//  ExerciseAPIService.swift
//  Fitness-Nutriton-App
//
//  Created by Dylan Schneiderman on 4/20/23.
//

import Foundation

protocol ExerciseAPI {
    func fetchExercisesByName(search: String) async throws -> [ExerciseResponse]
    func fetchExercisesByMuscle(search: String) async throws -> [ExerciseResponse]
}

struct ExerciseAPIService: ExerciseAPI, APIClient {
    func fetchExercisesByName(search: String) async throws -> [ExerciseResponse] {
        let path = ExerciseAPIEndpoint.path(isName: true, search: search)
        let response: [ExerciseResponse] = try await performRequest(url: path, isExercise: true)
        return response
    }
    
    func fetchExercisesByMuscle(search: String) async throws -> [ExerciseResponse] {
        let path = ExerciseAPIEndpoint.path(isName: false, search: search)
        let response: [ExerciseResponse] = try await performRequest(url: path, isExercise: true)
        return response
    }
    
    let session: URLSession = .shared
}
