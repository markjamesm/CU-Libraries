/*
OccupancyView.swift

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

struct OccupancyView: View {
    
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
       
        VStack {
        
            VStack(alignment: .leading) {
        
            HStack {
                Text("Webster Library")
                    .font(.headline)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(self.applogic.websterOccupancy) people in the library")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .padding()
            .background(Color.init(.systemBlue))
            .cornerRadius(20, corners: [.topLeft, .topRight])

            HStack {
                Text("Vanier Library ")
                    .font(.headline)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(self.applogic.vanierOccupancy) people in the library")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .padding()
            .background(Color.init(.systemGreen))
          //  .cornerRadius(30)
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Last Updated")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                      Spacer()
                    Text("\(self.applogic.time)")
                        .font(.subheadline)
                          .padding()
                  //    Spacer()
                  }
                  .padding()
                  .background(Color.init(.systemBlue))
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            }
            
        }
    }
    }
}

struct OccupancyView_Previews: PreviewProvider {
    static var previews: some View {
        
        OccupancyView().environmentObject(AppLogic())
    }
}
