//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Sheree Morrison on 16/7/2025.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    @StateObject private var vm =  LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
