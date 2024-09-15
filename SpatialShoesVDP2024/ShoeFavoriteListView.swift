//
//  ShoeFavoriteListView.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 15/9/24.
//

import SwiftUI

struct ShoeFavoriteListView: View {
    
    @Environment(ShoesViewModel.self) private var shoesVM
    @State private var rotationAngle = 0.0
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let columnsCount = max(1, Int(width / 336))
            let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 16), count: columnsCount)
            
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 16) {
                    ForEach(shoesVM.favoriteShoes) { shoe in
                        NavigationLink(destination: ShoeDetailView(shoe: shoe)) {
                            ShoeFavoriteCell(shoe: shoe, rotationAngle: $rotationAngle)
                                .frame(width: width / CGFloat(columnsCount) - 16)
                                .padding(.horizontal, 16)
                        }
                        .buttonStyle(CellListButton())
                    }
                }
            }
            .padding(.horizontal, 32)
            .onAppear {
                doRotation()
            }
        }
    }
    
    private func doRotation() {
        let rotationTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            let angle = rotationAngle + 0.2
            rotationAngle = angle < 360 ? angle : 0
        }
        RunLoop.current.add(rotationTimer, forMode: .common)
    }
}

#Preview(windowStyle: .automatic) {
    NavigationStack {
        ShoeFavoriteListView.preview
            .padding()
    }
    .environment(ShoesViewModel())
}
