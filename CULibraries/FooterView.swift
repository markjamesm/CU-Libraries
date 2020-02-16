/*
FooterView.swift

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

struct FooterView: View {
    
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
        
        VStack {
        Spacer()
        HStack {
            
            Text("Last Updated")
                .font(.subheadline)
                .foregroundColor(Color(.systemGray6))
                .padding()
            Spacer()
            Text("\(self.applogic.time)")
                .font(.subheadline)
                .foregroundColor(Color(.systemGray6))
                .padding()
          //  Spacer()
            
            Button(action: {
                
                self.applogic.getOccupancyRates()
                
            }) {
                Text("Refresh")
                    .font(.body)
                    .foregroundColor(Color(.systemTeal))
                    .padding()
                
            }
          }
          .background(Color.init(.systemBlue))
          .cornerRadius(20, corners: [.topLeft, .topRight])
        
        }
        
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView().environmentObject(AppLogic())
    }
}
