/*
LibraryData.swift

CULibraries, an Open Source Concordia University libraries app.
Created using the Concordia Opendata API.

https://github.com/opendataConcordiaU/documentation

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import Foundation

// These structs are used to model the various JSON response from the Open Data API.

// Codeables for the Library Occupancy data
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

//Library booking codeables
// MARK: - LibraryBookingElement
struct LibraryBookingElement: Codable, Identifiable, Hashable {

    public var id = UUID()
    public var resourceID, name, scheduleID: String

    enum CodingKeys: String, CodingKey {
           case resourceID = "resourceID"
           case name = "name"
           case scheduleID = "scheduleID"
    }
}

typealias LibraryBooking = [LibraryBookingElement]

// Library hour codeables
// MARK: - LibraryHour
struct LibraryHour: Codable, Identifiable {
    public var id = UUID()
    var service, text: String

    enum CodingKeys: String, CodingKey {
            case service = "service"
            case text = "text"
     }

}

typealias LibraryHours = [LibraryHour]

// MARK: - LibraryReservationElement
struct LibraryReservationElement: Codable, Identifiable {
    let id = UUID()
    let referenceNumber: ReferenceNumber
  //  let startDate, endDate: String
    let startDate, endDate: Date?
}

//enum StartDate: Codeable {
//    case date(Date)
//    case null(Nil)
    
//}

enum ReferenceNumber: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
          //  self = .string(String(""))
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ReferenceNumber.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ReferenceNumber"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

typealias LibraryReservation = [LibraryReservationElement]

// Library computer availability codeables
// MARK: - LibraryComputers
struct LibraryComputers: Codable, Identifiable {
    let id = UUID()
    let webster: Webster
    let vanier: Vanier

    enum CodingKeys: String, CodingKey {
        case webster = "Webster"
        case vanier = "Vanier"
    }
}

// MARK: - Vanier
struct Vanier: Codable {
    let desktops: VanierDesktops
    let laptops, tablets: String

    enum CodingKeys: String, CodingKey {
        case desktops = "Desktops"
        case laptops = "Laptops"
        case tablets = "Tablets"
    }
}

// MARK: - VanierDesktops
struct VanierDesktops: Codable {
    let vl122, vl201, vlEntrance: String

    enum CodingKeys: String, CodingKey {
        case vl122 = "VL-122"
        case vl201 = "VL-201"
        case vlEntrance = "VL-Entrance"
    }
}

// MARK: - Webster
struct Webster: Codable {
    let desktops: WebsterDesktops
    let laptops, tablets: String

    enum CodingKeys: String, CodingKey {
        case desktops = "Desktops"
        case laptops = "Laptops"
        case tablets = "Tablets"
    }
}

// MARK: - WebsterDesktops
struct WebsterDesktops: Codable {
    let lb245, lb285, lb345, lb385: String
    let lb445, lb485, lb545: String

    enum CodingKeys: String, CodingKey {
        case lb245 = "LB-245"
        case lb285 = "LB-285"
        case lb345 = "LB-345"
        case lb385 = "LB-385"
        case lb445 = "LB-445"
        case lb485 = "LB-485"
        case lb545 = "LB-545"
    }
}
