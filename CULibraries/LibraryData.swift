/*
LibraryData.swift

CULibraries, an app to see the current occupancy of the Concordia University libraries in Montreal, Quebec.

Created by Mark-James M. using the Concordia Opendata API.

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
