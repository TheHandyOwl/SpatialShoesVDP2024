//
//  ShoeCarrouselView.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 18/8/24.
//

import SwiftUI

struct GenericCarrouselSectionData: Identifiable {
    let id = UUID()
    let title: String
    let shoes: [ShoeModel]
}

struct ShoeCarouselListView: View {
    
    let sections: [GenericCarrouselSectionData]
    
    var body: some View {
        ScrollView {
            ForEach(sections) { section in
                VStack(alignment: .leading) {
                    Text(section.title)
                        .font(.title)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 32) {
                            ForEach(section.shoes) { shoe in
                                NavigationLink(destination: ShoeDetailView(shoe: shoe)) {
                                    ShoeCarrouselCell(shoe: shoe)
                                }
                                .buttonStyle(.plain)
                                .buttonBorderShape(.roundedRectangle(radius: 32))
                            }
                        }
                        .safeAreaPadding(.horizontal)
                    }
                    .scrollIndicators(.never)
                }
                .padding(.bottom, 32)
            }
        }
        .scrollIndicators(.never)
    }
}

#Preview(windowStyle: .automatic) {
    NavigationStack {
        ShoeCarouselListView.preview
            .padding()
    }
}
