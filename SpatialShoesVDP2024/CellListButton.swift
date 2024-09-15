//
//  CellListButton.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 7/9/24.
//

import SwiftUI

struct CellListButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .buttonBorderShape(.roundedRectangle(radius: 32))
            .hoverEffect(.highlight)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
