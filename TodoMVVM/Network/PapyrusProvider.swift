//
//  PapyrusProvider.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/15/26.
//

import PapyrusAlamofire

let provider = Provider(
    baseURL: "https://mtdev.runflare.run/api/",
    session: NetworkManager.shared.session
)

// Optional: Add global intercept for logging or further mods
//provider = provider.intercept { request, next in
//    print("Request: \(request.method) \(request.url?.absoluteString ?? "")")
//    let response = try await next(request)
//    print("Response: \(response.statusCode)")
//    return response
//}

let authAPI: AuthProtocol = AuthProtocolAPI(provider: provider)
