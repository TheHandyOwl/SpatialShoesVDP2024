//
//  ShoeWithGesturesView.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 7/9/24.
//

import SwiftUI
import RealityKit
import SpatialShoesVDP2024__3DAssets

struct ShoeWithGesturesView: View {
    
    @Environment(ShoesViewModel.self) private var shoesVM
    
    @State private var showHelp = false
    
    // Rotation
    @State private var rotationIsEnabled = true
    @State private var rotationFactor = 2.0
    @State private var rotationAngle = 0.0
    
    // Inertia
    @State private var currentRotation = CGFloat(0.0)
    @State private var lastDragValue = CGFloat(0.0)
    @State private var velocity = CGFloat(0.0)
    
    @State var initialScale = CGFloat(1.2)
    @State private var scaleMagnified = Double(1.2)
    
    var body: some View {
        if let shoe = shoesVM.selectedShoe {
            ZStack {
                Model3D(named: shoe.model3DName, bundle: spatialShoesVDP2024__3DAssetsBundle) { shoeModel in
                    shoeModel
                        .scaleEffect(scaleMagnified)
                        .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
                        .rotation3DEffect(.degrees(Double(currentRotation)), axis: (x: 0, y: 1, z: 0))
                } placeholder: {
                    Image(systemName: "shoe.2.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(16)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .symbolEffect(.pulse)
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let delta = value.translation.width - lastDragValue
                            velocity = delta / 10
                            lastDragValue = value.translation.width
                            currentRotation += velocity
                        }
                        .onEnded { _ in
                            lastDragValue = 0.0
                            startInertia()
                        }
                )
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            let newScale = initialScale - (1.0 - value.magnification)
                            if 0.4...2.1 ~= newScale {
                                scaleMagnified = newScale
                            }
                        }
                        .onEnded { value in
                            initialScale = scaleMagnified
                        }
                )
                .toolbar {
                    ToolbarItem(placement: .bottomOrnament) {
                        HStack(spacing: 32) {
                            Button("<<") {
                                rotationFactor -= rotationFactor != 4 ? 4 : 8
                            }
                            Button("<") {
                                rotationFactor -= rotationFactor != 2 ? 2 : 4
                            }
                            Toggle(isOn: $rotationIsEnabled) {
                                Image(systemName: rotationIsEnabled ? "stop" : "play")
                            }
                            Button {
                                showHelp = true
                            } label: {
                                Image(systemName: "questionmark.bubble")
                            }
                            Button(">") {
                                rotationFactor += rotationFactor != -2 ? 2 : 4
                            }
                            Button(">>") {
                                rotationFactor += rotationFactor != -4 ? 4 : 8
                            }
                        }
                        .padding()
                        .glassBackgroundEffect(in: .capsule)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    doRotation()
                }
                .fullScreenCover(isPresented: $showHelp) {
                    ZStack {
                        Color.clear.ignoresSafeArea()
                        ShoeHelpView()
                            .background(Color.clear)
                    }
                }
            }
        } else {
            Text("No hay un zapato seleccionado")
        }
    }
    
    private func doRotation() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            guard rotationIsEnabled else { return }
            var rotationVelocity = 0.2 * rotationFactor
            switch rotationFactor {
            case ...(-20.0):
                rotationFactor = -20.0
                rotationVelocity = -4
            case 20.0...:
                rotationFactor = 20.0
                rotationVelocity = 4
            default:
                break
            }
            let angle = rotationAngle + rotationVelocity
            rotationAngle = rotationAngle < 360 ? angle : 0
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func startInertia() {
        let inertialTimer =  Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { timer in
            if abs(velocity) < 0.01 {
                timer.invalidate()
            } else {
                velocity *= 0.95
                currentRotation += velocity
            }
        }
        RunLoop.current.add(inertialTimer, forMode: .common)
    }
}

#Preview {
    NavigationStack {
        let shoesVM = ShoesViewModel()
        shoesVM.selectedShoe = ShoeModel.shoeMock
        return ShoeWithGesturesView()
            .environment(shoesVM)
    }
}
