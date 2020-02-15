/*
HeaderView.swift

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

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

// Define the rounded corner shape so we can use our corner specific rounding function

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct HeaderView: View {
    
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
       
        VStack {
        HStack {
            Text("CU Libraries Occupancy")
                .font(.body)
                .foregroundColor(Color.white)
            Spacer()
            Button(action: {
                
                self.applogic.getOccupancyRates()
                
            }) {
                Text("Refresh")
                    .font(.body)
                    .foregroundColor(Color(.blue))
                
            }
        }
        .padding()
        .background(Color.init(.systemGreen))
           // .cornerRadius(25)
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])

        ImageView()
            .padding()
            Spacer()
            OccupancyView()
            Spacer()
        }
        }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView().environmentObject(AppLogic())
    }
}
