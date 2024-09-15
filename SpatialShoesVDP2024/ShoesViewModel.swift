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
        case .beLucky: "¡Voy a tener suerte!"
        case .byBrand: "Por marca"
        case .byMaterial: "Por material"
        case .byPrice: "Por precio"
        case .byType: "Por tipo"
        case .favoriteShoes: "Mis favoritos"
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
    case byMaterial([GenericCarrouselSectionData])
    case byPrice([GenericCarrouselSectionData])
    case byType([GenericCarrouselSectionData])
    case favoriteShoes
}

let FAVORITE_SHOE_KEY = "favoriteShoes"

@Observable
final class ShoesViewModel {
    
    let interactor: DataInteractor
    
    var mainSections = [MainSection]()
    var shoes = [ShoeModel]()
    var selectedShoe: ShoeModel?
    var favoriteShoes: [ShoeModel] {
        self.shoes.filter { $0.isFavorite }
    }
    
    @ObservationIgnored var errorMsg = ""
    var showAlert = false
    
    private var favoriteShoesIds = Set<ShoeModel>() {
        didSet {
            self.updateShoesAreFavorite()
        }
    }
    
    init(interactor: DataInteractor = Interactor()) {
        self.interactor = interactor
        do {
            let shoes = try self.interactor.getShoes()
            self.shoes = shoes
            self.mainSections = self.getSections(shoes)
            self.loadFavoriteShoes()
        } catch {
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
            MainSection(order: 1, data: .byBrand(self.getSectionsByBrand(shoes))),
            MainSection(order: 2, data: .byMaterial(self.getSectionsByMaterial(shoes))),
            MainSection(order: 3, data: .byPrice(self.getSectionsByPrice(shoes))),
            MainSection(order: 4, data: .byType(self.getSectionsByType(shoes))),
            MainSection(order: 5, data: .favoriteShoes)]
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
    
    private func getSectionsByMaterial(_ shoes: [ShoeModel]) -> [GenericCarrouselSectionData] {
        Set(shoes.flatMap(\.materials))
            .sorted()
            .map { material in
                GenericCarrouselSectionData(
                    title: material,
                    shoes: shoes.filter { $0.materials.contains(material) })
            }
    }
    
    private func getSectionsByPrice(_ shoes: [ShoeModel]) -> [GenericCarrouselSectionData] {
        let sectionsData: [(title: String, shoesRange: ClosedRange<Double>)] = [
            ("Less than $30", 0...29.99),
            ("$30 - $49.99", 30...59.99),
            ("$50 - $89.99", 60...89.99),
            ("More than $90", 90...Double.infinity)
        ]
        return sectionsData
            .map { sectionData in
                GenericCarrouselSectionData(
                    title: sectionData.title,
                    shoes: shoes.filter { sectionData.shoesRange.contains($0.price) })
            }
            .filter { !$0.shoes.isEmpty }
    }
    
    private func getSectionsByType(_ shoes: [ShoeModel]) -> [GenericCarrouselSectionData] {
        Set(shoes.map(\.typeOf))
            .sorted()
            .map { typeOf in
                GenericCarrouselSectionData(
                    title: typeOf,
                    shoes: shoes.filter { $0.typeOf == typeOf })
            }
    }
    
    func toggleFavorite(shoe: ShoeModel) {
        if self.favoriteShoesIds.contains(where: { $0.id == shoe.id }) {
            self.removeFavorite(shoe: shoe)
        } else {
            self.addFavorite(shoe: shoe)
        }
    }
    
    private func addFavorite(shoe: ShoeModel) {
        guard !self.favoriteShoesIds.contains(where: { $0.id == shoe.id }) else { return }
        self.saveFavoriteShoes()
        self.favoriteShoesIds.insert(shoe)
        self.saveFavoriteShoes()
    }
    
    private func removeFavorite(shoe: ShoeModel) {
        self.favoriteShoesIds.remove(shoe)
        self.saveFavoriteShoes()
    }
    
    private func saveFavoriteShoes() {
        self.interactor.saveFavoriteShoes(self.favoriteShoesIds.map(\.id))
    }
    
    private func loadFavoriteShoes() {
        let shoeIds = self.interactor.loadFavoriteShoes()
        self.favoriteShoesIds = Set(self.shoes.filter { shoeIds.contains($0.id) })
    }
    
    private func updateShoesAreFavorite() {
        self.shoes = self.shoes.map { shoe in
            var favoriteShoe = shoe
            favoriteShoe.isFavorite = self.favoriteShoesIds.map(\.id).contains(shoe.id)
            print("--> favoriteShoe.isFavorite: \(favoriteShoe.isFavorite)")
            return favoriteShoe
        }
    }
}
