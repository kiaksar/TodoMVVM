//
//  Endpoint.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/14/26.
//

import Foundation
struct Endpoint {
    let path: String
    let method: httpMethod
    let body: Data?
    
    // query params, headers, etc ...
}

enum httpMethod: String {
    case get, post, put, delete
}
