/*
FooterView.swift

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

import SwiftUI

struct FooterView: View {
    
    @State private var refreshAlertShown = false
    
    @EnvironmentObject var applogic: AppLogic
    
      let refreshAlert = Alert(title: Text("Notice"), message: Text("Realtime estimate of people inside the libraries is based on data collected by door sensors. Some values may return negative numbers as the counters reset at midnight when some people may still be in the library."), dismissButton: Alert.Button.default(Text("Dismiss")))
    
    var body: some View {
        
        HStack {
            
            Text("Last updated")
                .font(.subheadline)
                .foregroundColor(Color(.systemGray6))
                .padding()
            
            Spacer()
            
            Text("\(self.applogic.time)")
                .font(.subheadline)
                .foregroundColor(Color(.systemGray6))
                .padding()
            Spacer()
            Button(action: {
                
                self.applogic.getOccupancyRates()
                self.refreshAlertShown = true
                
            }) {
                Text("Refresh")
                .font(.body)
                .foregroundColor(Color(.systemTeal))
                .padding()
            }.alert(isPresented: $refreshAlertShown) {refreshAlert}
        }
          .background(Color.init(.systemBlue))
          .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView().environmentObject(AppLogic())
    }
}
