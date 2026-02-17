//
//  ContentView.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/8/26.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            LoginView()
                .navigationDestination(for: NavPath.self) { destination in
                    destinationView(for: destination)
                }
        }
    }
}

#Preview {
    ContentView()
}
