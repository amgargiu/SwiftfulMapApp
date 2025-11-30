//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Antonio Gargiulo on 11/21/25.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm) //now in env, any view that is within or child of that view has access to it by calling @EnvObj
            
        }
    }
}
