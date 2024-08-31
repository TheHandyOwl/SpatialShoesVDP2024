//
//  ShoeModel+Extension.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 18/8/24.
//

import Foundation

extension ShoeModel {

    static let shoeMock = ShoeModel(
        id: 10123,
        name: "Air Jordan for testing",
        brand: .urbanStride,
        size: [38, 39, 40, 41, 42, 43, 44],
        price: 99.99,
        information: "Descubre la combinación perfecta entre estilo y comodidad con nuestras **Urban Explorer** de **UrbanStride**. Diseñadas para aquellos que buscan un calzado versátil y moderno, estas botas de cuero tipo zapatillas ofrecen una apariencia robusta y sofisticada sin sacrificar el confort. Confeccionadas con cuero de alta calidad, estas botas son ideales tanto para el día a día como para ocasiones especiales.\n\n**Características Destacadas:**\n- **Material:** Cuero genuino que proporciona durabilidad y un acabado premium.\n- **Diseño:** Una fusión de la clásica bota y la moderna zapatilla, perfecta para cualquier atuendo.\n- **Comodidad:** Plantilla acolchada y soporte óptimo para largas jornadas.\n- **Versatilidad:** Disponible en múltiples tallas para adaptarse a todas tus necesidades.\n\nDéjate seducir por el estilo atemporal y la elegancia de nuestras **Urban Explorer**, y lleva tu look al siguiente nivel.",
        model3DName: "AirJordan",
        typeOf: "Botas",
        materials: ["Cuero"],
        origin: "Alemania",
        gender: .unisex,
        weight: 1.2,
        colors: [.negro,
                 .marrón],
        warranty: 2,
        certifications: ["Certificación de Calidad",
                         "Hecho a mano"]
    )
    
    static let shoesMock = [
        ShoeModel(
            id: 10123,
            name: "Urban Explorer",
            brand: .urbanStride,
            size: [38, 39, 40, 41, 42],
            price: 99.99,
            information: "Descubre la combinación perfecta entre estilo y comodidad con nuestras **Urban Explorer** de **UrbanStride**. Diseñadas para aquellos que buscan un calzado versátil y moderno, estas botas de cuero tipo zapatillas ofrecen una apariencia robusta y sofisticada sin sacrificar el confort. Confeccionadas con cuero de alta calidad, estas botas son ideales tanto para el día a día como para ocasiones especiales.\n\n**Características Destacadas:**\n- **Material:** Cuero genuino que proporciona durabilidad y un acabado premium.\n- **Diseño:** Una fusión de la clásica bota y la moderna zapatilla, perfecta para cualquier atuendo.\n- **Comodidad:** Plantilla acolchada y soporte óptimo para largas jornadas.\n- **Versatilidad:** Disponible en múltiples tallas para adaptarse a todas tus necesidades.\n\nDéjate seducir por el estilo atemporal y la elegancia de nuestras **Urban Explorer**, y lleva tu look al siguiente nivel.",
            model3DName: "leatherShoes",
            typeOf: "Botas",
            materials: ["Cuero"],
            origin: "Alemania",
            gender: .unisex,
            weight: 1.2,
            colors: [.negro,
                     .marrón],
            warranty: 2,
            certifications: ["Certificación de Calidad",
                             "Hecho a mano"]
        ),
        ShoeModel(
            id: 10234,
            name: "Retro Runner",
            brand: .eleganceWalk,
            size: [39, 40, 41, 42, 43],
            price: 79.99,
            information: "Revive el encanto del pasado con nuestras **Retro Runner** de **EleganceWalk**. Inspirados en el estilo deportivo de antaño, estos zapatos deportivos retro ofrecen un diseño auténtico y una comodidad excepcional. Perfectos para los amantes de la moda vintage que buscan destacarse con un toque clásico y deportivo.\n\n**Características Destacadas:**\n- **Material:** Cuero y materiales sintéticos de alta calidad que garantizan durabilidad y estilo.\n- **Diseño:** Auténtico estilo retro que combina funcionalidad y moda.\n- **Comodidad:** Plantilla ergonómica y suela acolchada para un confort superior.\n- **Versatilidad:** Ideal para uso diario o actividades deportivas ligeras, disponibles en varias tallas.\n\nHaz una declaración de estilo con nuestras **Retro Runner** y añade un toque vintage a tu colección de calzado.",
            model3DName: "oldFashionSportShoes",
            typeOf: "Deportivas",
            materials: ["Cuero"],
            origin: "Alemania",
            gender: .unisex,
            weight: 1.2,
            colors: [.rojo, .blanco, .negro],
            warranty: 2,
            certifications: ["Certificación de Calidad",
                             "Hecho a mano"]
        ),
        ShoeModel(
            id: 10345,
            name: "Sporty Chic",
            brand: .eleganceWalk,
            size: [36, 37, 38, 39, 40],
            price: 89.99,
            information: "Descubre la combinación perfecta entre estilo y comodidad con nuestras **Urban Explorer** de **UrbanStride**. Diseñadas para aquellos que buscan un calzado versátil y moderno, estas botas de cuero tipo zapatillas ofrecen una apariencia robusta y sofisticada sin sacrificar el confort. Confeccionadas con cuero de alta calidad, estas botas son ideales tanto para el día a día como para ocasiones especiales.\n\n**Características Destacadas:**\n- **Material:** Cuero genuino que proporciona durabilidad y un acabado premium.\n- **Diseño:** Una fusión de la clásica bota y la moderna zapatilla, perfecta para cualquier atuendo.\n- **Comodidad:** Plantilla acolchada y soporte óptimo para largas jornadas.\n- **Versatilidad:** Disponible en múltiples tallas para adaptarse a todas tus necesidades.\n\nDéjate seducir por el estilo atemporal y la elegancia de nuestras **Urban Explorer**, y lleva tu look al siguiente nivel.",
            model3DName: "fashionSportShoe",
            typeOf: "Deportivas",
            materials: ["Sintético", "Textil"],
            origin: "Estados Unidos",
            gender: .unisex,
            weight: 0.8,
            colors: [.rojo, .blanco, .negro],
            warranty: 2,
            certifications: ["Materiales Reciclados",
                             "Libre de Crueldad"]
        ),
    ]
}
