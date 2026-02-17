//
//  AuthAPIProtocol.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/15/26.
//

import PapyrusAlamofire

@API
@JSON
protocol AuthProtocol {
    @POST("/auth/login/")
    func login(email: String, password: String) async throws -> Response
    
    @POST("/auth/register/")
    func register(email: String, password: String) async throws -> Response
}

