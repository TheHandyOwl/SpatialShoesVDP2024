//
//  SpatialShoesVDP2024App.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 18/8/24.
//

import SwiftUI

@main
struct SpatialShoesVDP2024App: App {
    
    @State private var shoesVM = ShoesViewModel()
    
    var body: some Scene {
        WindowGroup(id: "mainWindow") {
            HomeView()
                .frame(minWidth: 1280, maxWidth: 2560, minHeight: 720, maxHeight: 1440)
                .environment(shoesVM)
        }
        .windowResizability(.contentSize)
        WindowGroup(id: "shoeGesture") {
            ShoeWithGesturesView()
                .frame(minWidth: 1280, maxWidth: 2560, minHeight: 720, maxHeight: 1440)
                .environment(shoesVM)
        }
        .windowResizability(.contentSize)
    }
}
