//
//  networkCallsFunction.swift
//  Api_calls_swiftUI
//
//  Created by ilyass Serghini on 2024-04-30.
//

import Foundation

func getUser() async throws -> GitHubUser {
    let endpoint = "https://api.github.com/users/facebook"
    
    guard let url = URL(string: endpoint) else {
        throw GHError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GitHubUser.self, from: data)
    } catch {
        throw GHError.invalidData
    }
}
