//
//  TodoMVVMApp.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/8/26.
//

import SwiftUI

@main
struct TodoMVVMApp: App {
    
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }
    }
}
