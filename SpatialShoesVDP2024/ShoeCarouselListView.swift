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
    
    @Environment(ShoesViewModel.self) private var shoesVM
    
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
                                .buttonStyle(CellListButton())
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
    VStack {
        NavigationStack {
            ShoeCarouselListView.preview
                .padding()
        }
    }
    .environment(ShoesViewModel())
}
