//
//  ShoeDetailView.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 23/8/24.
//

import SwiftUI

struct ShoeDetailView: View {
    let shoe: ShoeModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            shoeInformation
            shoe3D
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("\(shoe.brand.rawValue): \(shoe.name)")
        .safeAreaPadding(32)
    }
    
    private var shoeInformation: some View {
        Form {
            Section(header: Text("Información").font(.myHeadline)) {
                LabeledContent("**Tallas**", value: shoe.size.map { String($0) }.joined(separator: ", "))
                    .font(.myBody)
                LabeledContent("**Colores**", value: shoe.colors.map(\.rawValue).joined(separator: ", "))
                    .font(.myBody)
                LabeledContent("**Tipo**", value: shoe.typeOf)
                    .font(.myBody)
                LabeledContent("**Materiales**", value: shoe.materials.joined(separator: ", "))
                    .font(.myBody)
            }
            Section(header: Text("Descripción").font(.myHeadline)) {
                Text(LocalizedStringKey(shoe.information))
                    .font(.myBody)
            }
            
        }
        .frame(minWidth: 300, alignment: .topLeading)
    }
    
    private var shoe3D: some View {
        Image(systemName: "shoe.2.fill")
            .resizable()
            .scaledToFit()
            .padding(16)
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .symbolEffect(.pulse)
            .glassBackgroundEffect()
    }
}

#Preview(windowStyle: .automatic) {
    NavigationStack {
        ShoeDetailView.preview
    }
}
