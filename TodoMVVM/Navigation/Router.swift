//
//  Router.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/17/26.
//

import Foundation
import Combine

class Router: ObservableObject {
    @Published var path: [NavPath] = []
    
    func push(_ destination: NavPath) {
        path.append(destination)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func pop(count: Int) {
        guard count <= path.count else { return }
        path.removeLast(count)
    }
    
    func navigateToRootAndPush(_ destination: NavPath) {
        path = [destination]
    }
}
