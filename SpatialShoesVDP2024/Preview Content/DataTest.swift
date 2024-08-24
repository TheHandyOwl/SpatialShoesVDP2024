//
//  DataTest.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 18/8/24.
//

import Foundation

struct DataTest: DataInteractor {
    var url: URL { Bundle.main.url(forResource: "shoesTest", withExtension: "json")! }
}
