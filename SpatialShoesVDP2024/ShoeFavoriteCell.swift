//
//  ShoeFavoriteCell.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 15/9/24.
//

import SwiftUI
import RealityKit
import SpatialShoesVDP2024__3DAssets

struct ShoeFavoriteCell: View {
    
    let shoe: ShoeModel
    @Binding var rotationAngle: Double
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Model3D(named: shoe.model3DName, bundle: spatialShoesVDP2024__3DAssetsBundle) { shoeModel in
                shoeModel
                    .rotation3DEffect(
                        .degrees(rotationAngle),
                        axis: (x: 0, y: 1, z: 0))
                    .scaleEffect(0.6)
                    .frame(maxWidth: .infinity, maxHeight: 250)
            } placeholder: {
                Image(systemName: "shoe.2.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(16)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .symbolEffect(.pulse)
            }
            Text(shoe.name)
                .font(.myHeadline)
                .bold()
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassBackgroundEffect()
        }
        .safeAreaPadding(16)
        .frame(width: 320, height: 403, alignment: .bottom)
    }
}

#Preview("ShoeFavoriteCell", windowStyle: .automatic) {
    ShoeFavoriteCell.preview
}

#Preview(windowStyle: .automatic) {
    NavigationStack {
        ShoeFavoriteListView.preview
            .padding()
    }
    .environment(ShoesViewModel())
}
