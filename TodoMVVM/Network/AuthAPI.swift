//
//  AuthService.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/9/26.
//

import Foundation

class AuthAPI {
    
    func authRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let reqURL = apiBaseURL.appending(endpoint.path)
        guard let reqURL = URL(string: reqURL.description) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: reqURL)
        request.httpMethod = endpoint.method.rawValue.uppercased()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKeySecret, forHTTPHeaderField: "X-API-Key")
        request.httpBody = endpoint.body
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
