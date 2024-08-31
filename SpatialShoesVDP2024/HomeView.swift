//
//  HomeView.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 20/8/24.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(ShoesViewModel.self) private var shoesVM
    @State private var selectedSection: MainSection?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedSection) {
                ForEach(shoesVM.mainSections) { section in
                    Text(section.title)
                        .font(.myBody)
                        .tag(section)
                }
            }
            .navigationSplitViewColumnWidth(250)
            .navigationTitle("Showroom")
        } detail: {
            switch selectedSection?.data {
            case .beLucky(let shoe):
                ShoeDetailView(shoe: shoe)
            case .byBrand(let sections),
                    .byPrice(let sections),
                    .byMaterial(let sections),
                    .byType(let sections):
                NavigationStack {
                    ShoeCarouselListView(sections: sections)
                        .navigationTitle(selectedSection?.title ?? "")
                        .id(selectedSection?.id)
                }
            default:
                VStack {
                    Text("Selecciona una opción para ver la información.")
                        .font(.myBody)
                        .padding()
                    Image(systemName: "shoe.2.fill")
                        .symbolEffect(.pulse)
                }
            }
        }
        .navigationSplitViewStyle(.balanced)
        .onChange(of: selectedSection) { _, _ in
            shoesVM.selectionChanged()
        }
    }
}

#Preview(windowStyle: .automatic) {
    HomeView()
        .environment(ShoesViewModel())
}
