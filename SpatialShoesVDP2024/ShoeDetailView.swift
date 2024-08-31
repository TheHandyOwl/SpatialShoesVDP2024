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
    
    @State private var rotationAngle = 0.0
    @State private var rotationIsEnabled = true
    
    let shoe: ShoeModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            shoeInformation
                .frame(minWidth: 300, alignment: .topLeading)
            shoe3D
                .glassBackgroundEffect()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top)
        .safeAreaPadding(32)
        .navigationTitle("\(shoe.brand.rawValue): \(shoe.name)")
        .toolbar {
            ToolbarItem(placement: .bottomOrnament) {
                Toggle(isOn: $rotationIsEnabled) {
                    Image(systemName: rotationIsEnabled ? "stop" : "play")
                }
                .frame(width: 100)
            }
        }
        .onAppear {
            self.doRotation()
        }
    }
    
    private var shoeInformation: some View {
        Form {
            Section(header: Text("Description").font(.myHeadline)) {
                Text(LocalizedStringKey(shoe.information))
                    .font(.myBody)
            }
            Section(header: Text("Information").font(.myHeadline)) {
                LabeledContent(
                    "**Size**",
                    value: shoe.size.map { String($0) }
                        .joined(separator: ", "))
                .font(.myBody)
                LabeledContent(
                    "**Colors**",
                    value: shoe.colors.map(\.rawValue)
                        .joined(separator: ", "))
                .font(.myBody)
                LabeledContent(
                    "**Typo**",
                    value: shoe.typeOf)
                .font(.myBody)
                LabeledContent(
                    "**Materials**",
                    value: shoe.materials.joined(separator: ", "))
                .font(.myBody)
            }
        }
    }
    
    private var shoe3D: some View {
        Model3D(named: shoe.model3DName, bundle: spatialShoesVDP2024__3DAssetsBundle) { shoe in
            shoe
                .resizable()
                .scaledToFit()
                .scaleEffect(0.5)
                .rotation3DEffect(
                    .degrees(rotationAngle),
                    axis: (x: 0, y: 1, z: 0))
        } placeholder: {
            ZStack {
                shoeImage
                ProgressView()
                    .background(
                        Color.black.opacity(0.2)
                    )
            }
        }
        .frame(maxWidth: 800, maxHeight: .infinity, alignment: .center)
    }
    
    private var shoeImage: some View {
        Image(systemName: "shoe.2.fill")
            .resizable()
            .scaledToFit()
            .padding(16)
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .symbolEffect(.pulse)
            .glassBackgroundEffect()
    }
    
    private func doRotation() {
        let rotationTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            guard rotationIsEnabled else { return }
            let angle = rotationAngle + 0.2
            rotationAngle = angle < 360 ? angle : 0
        }
        RunLoop.current.add(rotationTimer, forMode: .common)
    }
}

#Preview(windowStyle: .automatic) {
    NavigationStack {
        ShoeDetailView.preview
    }
}
