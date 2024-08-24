//
//  ShoesViewModel.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 18/8/24.
//

import Foundation

struct MainSection: Identifiable {
    let id = UUID()
    let order: Int
    let data: MainSectionData
    
    var title: String {
        switch data {
        case .beLucky: "I'm feeling lucky!"
        case .byBrand: "By brand"
        }
    }
}

extension MainSection: Equatable, Hashable {

    static func == (lhs: MainSection, rhs: MainSection) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum MainSectionData {
    case beLucky(ShoeModel)
    case byBrand([GenericCarrouselSectionData])
}

@Observable
final class ShoesViewModel {
    
    let interactor: DataInteractor
    
    var mainSections = [MainSection]()
    let shoes: [ShoeModel]
    var selectedShoe: ShoeModel?
    
    @ObservationIgnored var errorMsg = ""
    var showAlert = false
    
    init(interactor: DataInteractor = Interactor()) {
        self.interactor = interactor
        do {
            let shoes = try self.interactor.getShoes()
            self.shoes = shoes
            self.mainSections = self.getSections(shoes)
        } catch {
            self.shoes = []
            errorMsg = "Error loading JSON file \(error)."
            showAlert.toggle()
        }
    }
    
    func selectionChanged() {
        guard let newShoe = self.shoes.randomElement() else { return }
        guard let index = self.mainSections.firstIndex(where: {
            guard case .beLucky = $0.data else { return false }
            return true
        }) else {
            return self.mainSections.append(
                MainSection(
                    order: (self.mainSections.map(\.order).max() ?? 0) + 1,
                    data: .beLucky(newShoe)
                )
            )
        }
        self.mainSections[index] = MainSection(
            order: self.mainSections[index].order,
            data: .beLucky(newShoe))
    }
    
    private func getSections(_ shoes: [ShoeModel]) -> [MainSection] {
        var sections = [
            MainSection(order: 1, data: .byBrand(self.getSectionsByBrand(shoes)))]
        if let shoe = shoes.randomElement() {
            sections.append(MainSection(order: 99, data: .beLucky(shoe)))
        }
        return sections
            .sorted(by: { $0.order < $1.order })
    }
    
    private func getSectionsByBrand(_ shoes: [ShoeModel]) -> [GenericCarrouselSectionData] {
        Set(shoes.map(\.brand))
            .sorted { $0.rawValue < $1.rawValue }
            .map { brand in
                GenericCarrouselSectionData(
                    title: brand.rawValue,
                    shoes: shoes.filter { $0.brand == brand })
            }
    }
}
