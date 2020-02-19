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

// These structs are used to model the JSON response from the Open Data API.

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
    let startDate, endDate: String
}

enum ReferenceNumber: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
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
