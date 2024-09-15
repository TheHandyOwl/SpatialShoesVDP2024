//
//  HomeView+Extension.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 18/8/24.
//

import SwiftUI

extension HomeView {
    static var preview: some View {
        HomeView()
            .environment(ShoesViewModel(interactor: DataTest()))
    }
}

extension ShoeCarrouselCell {
    static var preview: some View {
        ShoeCarrouselCell(shoe: ShoeModel.shoeMock)
    }
}

extension ShoeFavoriteCell {
    static var preview: some View {
        ShoeFavoriteCell(
            shoe: ShoeModel.shoeMock, rotationAngle: .constant(0.0)
        )
    }
}

extension ShoeCarouselListView {
    static var preview: some View {
        ShoeCarouselListView(
            sections: [
                GenericCarrouselSectionData(
                    title: "Title",
                    shoes: ShoeModel.shoesMock
                )
            ]
        )
    }
}

extension ShoeFavoriteListView {
    static var preview: some View {
        ShoeFavoriteListView()
    }
}

extension ShoeDetailView {
    static var preview: some View {
        ShoeDetailView(
            shoe: ShoeModel.shoeMock
        )
    }
}
