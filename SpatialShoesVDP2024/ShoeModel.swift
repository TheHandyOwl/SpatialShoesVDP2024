//
//  ShoeModel.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 18/8/24.
//

import Foundation

struct ShoeModel: Identifiable, Hashable {
    
    // MARK: properties
    let id: Int
    let name: String
    let brand: Brand
    let size: [Int]
    let price: Double
    let information: String
    let model3DName: String
    let typeOf: String
    let materials: [String]
    let origin: String
    let gender: Gender?
    let weight: Double
    let colors: [CustomColor]
    let warranty: Int
    let certifications: [String]
    
    // MARK: enums
    enum Brand: String, Codable {
        case athletica = "Athletica"
        case eleganceWalk = "EleganceWalk"
        case gentlemenStyle = "GentlemenStyle"
        case urbanStride = "UrbanStride"
        case unknoun = "N/A"
    }
    
    enum CustomColor: String, Codable {
        case blanco = "Blanco"
        case marrón = "Marrón"
        case negro = "Negro"
        case rojo = "Rojo"
    }
    
    enum Gender: String, Codable {
        case femenino = "Femenino"
        case masculino = "Masculino"
        case unisex = "Unisex"
    }
    
    // MARK: static methods
    static func map(_ dto: ShoeDTO) -> ShoeModel {
        ShoeModel(
            id: dto.id,
            name: dto.name,
            brand: ShoeModel.Brand(rawValue: dto.brand) ?? .unknoun,
            size: dto.size,
            price: dto.price,
            information: dto.description,
            model3DName: dto.model3DName,
            typeOf: dto.type,
            materials: dto.materials,
            origin: dto.origin,
            gender: ShoeModel.Gender(rawValue: dto.gender),
            weight: dto.weight,
            colors: dto.colors.compactMap { ShoeModel.CustomColor(rawValue: $0) },
            warranty: dto.warranty,
            certifications: dto.certifications
        )
    }
}
