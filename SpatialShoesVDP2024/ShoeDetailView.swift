//
//  ShoeDetailView.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 23/8/24.
//

import SwiftUI
import RealityKit
import SpatialShoesVDP2024__3DAssets

struct ShoeDetailView: View {
    
    @Environment(ShoesViewModel.self) private var shoesVM
    @Environment(\.openWindow) private var openWindow
    
    @State private var rotationAngle = 0.0
    
    let shoe: ShoeModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            shoeInformation
                .frame(minWidth: 300, alignment: .topLeading)
            shoe3D
        }
        .safeAreaPadding()
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top)
        .navigationTitle("\(shoe.brand.rawValue): \(shoe.name)")
        .toolbar {
            ToolbarItem(placement: .bottomOrnament) {
                Button {
                    shoesVM.selectedShoe = shoe
                    openWindow(id: "shoeGesture")
                } label: {
                    HStack {
                        Image(systemName: "hand.tap.fill")
                        Text("Experiencia interactiva")
                            .frame(width: 200)
                            .padding(10)
                    }
                }
                .glassBackgroundEffect()
            }
        }
        .onAppear {
            doRotation()
        }
    }
    
    private var shoeInformation: some View {
        Form {
            Section(header: Text("Descripción").font(.myHeadline)) {
                Text(LocalizedStringKey(shoe.information))
                    .font(.myBody)
            }
            Section(header: Text("Información").font(.myHeadline)) {
                LabeledContent(
                    "**Tamaño**",
                    value: shoe.size.map { String($0) }
                        .joined(separator: ", "))
                .font(.myBody)
                LabeledContent("**Colores**") {
                    HStack {
                        ForEach(shoe.colors, id: \.self) { colorName in
                            Circle()
                                .fill(getColorsView(colorName))
                                .frame(width: 20, height: 20) // Tamaño de los círculos
                        }
                    }
                }
                .font(.myBody)
                LabeledContent(
                    "**Tipo**",
                    value: shoe.typeOf)
                .font(.myBody)
                LabeledContent(
                    "**Materiales**",
                    value: shoe.materials.joined(separator: ", "))
                .font(.myBody)
            }
        }
    }
    
    private var shoe3D: some View {
        ZStack {
            Model3D(named: shoe.model3DName, bundle: spatialShoesVDP2024__3DAssetsBundle) { shoe in
                shoe
                    .rotation3DEffect(
                        .degrees(rotationAngle),
                        axis: (x: 0, y: 1, z: 0))
            } placeholder: {
                Image(systemName: "shoe.2.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(16)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .symbolEffect(.pulse)
            }
            .padding(64)
        }
        .frame(maxWidth: .infinity)
        .glassBackgroundEffect()
        .frame(maxWidth: 400, maxHeight: .infinity, alignment: .center)
    }
    
    private func doRotation() {
        let rotationTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            let angle = rotationAngle + 0.2
            rotationAngle = angle < 360 ? angle : 0
        }
        RunLoop.current.add(rotationTimer, forMode: .common)
    }
    
    private func getColorsView(_ colorName: ShoeModel.CustomColor) -> Color {
        switch colorName {
        case .blanco: .white
        case .marrón:.brown
        case .negro: .black
        case .rojo: .red
        }
    }
}

#Preview(windowStyle: .automatic) {
    NavigationStack {
        ShoeDetailView.preview
    }
    .environment(ShoesViewModel())
}
