//
//  DataInteractor.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 18/8/24.
//

import Foundation

protocol DataInteractor: JSONInteractor {
    var url: URL { get }
    func getShoes() throws -> [ShoeModel]
}

extension DataInteractor {
    var url: URL { Bundle.main.url(forResource: "shoes", withExtension: "json")! }
    
    func getShoes() throws -> [ShoeModel] {
        try loadJSON(url: url,
                     type: [ShoeDTO].self)
        .map(ShoeModel.map)
        .sorted { shoe1, shoe2 in
            shoe1.name.lowercased().compare(shoe2.name.lowercased()) == .orderedDescending
        }
        .sorted { shoe1, shoe2 in
            (shoe1.brand.rawValue).compare(shoe2.brand.rawValue) == .orderedDescending
        }
    }
}

struct Interactor: DataInteractor {}
