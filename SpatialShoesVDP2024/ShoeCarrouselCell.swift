//
//  ShoeCarrouselCell.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 24/8/24.
//

import SwiftUI

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct ShoeCarrouselCell: View {
    
    let shoe: ShoeModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(shoe.model3DName)
                .resizable()
                .scaledToFit()
                .padding(16)
                .frame(height: 210)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(
                    RoundedCorner(
                        radius: 32,
                        corners: [.topLeft, .topRight]))
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .top) {
                    Text("Nombre:")
                        .font(.myHeadline)
                        .bold()
                        .frame(width: 80, alignment: .topLeading)
                    Text(shoe.name)
                        .font(.myHeadline)
                        .bold()
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack(alignment: .top) {
                    Text("Marca:")
                        .font(.myHeadline)
                        .frame(width: 80, alignment: .topLeading)
                    Text(shoe.brand.rawValue)
                        .font(.myHeadline)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack(alignment: .top) {
                    Text("Tamaño:")
                        .font(.myHeadline)
                        .frame(width: 80, alignment: .topLeading)
                    Text(shoe.size.sorted().map { Bool.random() ? "\($0), \($0)" : "\($0)" }.joined(separator: ", "))
                        .font(.myHeadline)
                        .lineLimit(2)
                        .truncationMode(.middle)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                HStack {
                    Text(String(format: "$%.2f", shoe.price))
                        .font(.myHeadline)
                        .bold()
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(.ultraThickMaterial)
            .clipShape(
                RoundedCorner(
                    radius: 32,
                    corners: [.bottomLeft, .bottomRight]))
        }
        .padding(8)
        .frame(width: 368, height: 371)
        .glassBackgroundEffect(in: .rect(cornerRadius: 32))
    }
}

#Preview("ShoeCarrouselCell", windowStyle: .automatic) {
    ShoeCarrouselCell.preview
}

#Preview("ShoeCarouselListView", windowStyle: .automatic) {
    NavigationStack {
        ShoeCarouselListView.preview
            .padding()
    }
    .environment(ShoesViewModel())
}
