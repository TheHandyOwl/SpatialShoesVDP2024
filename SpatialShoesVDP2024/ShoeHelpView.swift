//
//  ShoeHelpView.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 13/9/24.
//

import SwiftUI

struct ShoeHelpView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                Text("**Drag gestures availables**")
                Text("- Arrastrar en horizontal para girar el objeto")
                Text("- Agrandar o empequeñecer el objeto")
            }
            .padding(.top, 50)
            .padding()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .symbolVariant(.fill)
                    .symbolVariant(.circle)
            }
            .safeAreaPadding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .padding()
    }
}

#Preview {
    ShoeHelpView()
}
