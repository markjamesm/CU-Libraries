//
//  LibraryData.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-09.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import Foundation

// MARK: - LibraryData
struct LibraryData: Codable {
    let webster, vanier, greyNuns: GreyNuns

    enum CodingKeys: String, CodingKey {
        case webster = "Webster"
        case vanier = "Vanier"
        case greyNuns = "GreyNuns"
    }
}

// MARK: - GreyNuns
struct GreyNuns: Codable {
    let occupancy, lastRecordTime: String

    enum CodingKeys: String, CodingKey {
        case occupancy = "Occupancy"
        case lastRecordTime = "LastRecordTime"
    }
}
