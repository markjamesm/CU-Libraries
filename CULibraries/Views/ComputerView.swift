/*
ComputerView.swift

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

struct ComputerView: View {
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
        VStack {
            NavigationView {

                List {
                Section(header: Text("Webster Library — Computer Rooms")) {
                    Text("LB-245: \(self.applogic.libraryComputers?.webster.desktops.lb245 ?? "") available")
                    Text("LB-285: \(self.applogic.libraryComputers?.webster.desktops.lb285 ?? "") available")
                    Text("LB-345: \(self.applogic.libraryComputers?.webster.desktops.lb345 ?? "") desktops available")
                    Text("LB-385: \(self.applogic.libraryComputers?.webster.desktops.lb385 ?? "") desktops available")
                    Text("LB-445: \(self.applogic.libraryComputers?.webster.desktops.lb445 ?? "") desktops available")
                    Text("LB-485: \(self.applogic.libraryComputers?.webster.desktops.lb485 ?? "") desktops available")
                    Text("LB-545: \(self.applogic.libraryComputers?.webster.desktops.lb545 ?? "") desktops available")
                    }
                    Section(header: Text("Webster Library — Portables")) {
                Text("Laptops: \(self.applogic.libraryComputers?.webster.laptops ?? "") available")
                Text("Tablets: \(self.applogic.libraryComputers?.webster.laptops ?? "") available")
                .font(.body)
            }
            Section(header: Text("Vanier Library — Computer Rooms")) {
                Text("VL-122: \(self.applogic.libraryComputers?.vanier.desktops.vl122 ?? "") desktops available")
                Text("VL-201: \(self.applogic.libraryComputers?.vanier.desktops.vl201 ?? "") desktops available")
                    }
                    
                Section(header: Text("Vanier Library — Portables")) {
                Text("Laptops: \(self.applogic.libraryComputers?.vanier.laptops ?? "") available")
                Text("Tablets: \(self.applogic.libraryComputers?.vanier.tablets ?? "") available")
            }
            
            }.listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Computer Availabilities"))
                
            Spacer()
        }
    VStack {
               FooterView()
    }
}
}
}

struct ComputerView_Previews: PreviewProvider {
    static var previews: some View {
        ComputerView().environmentObject(AppLogic())
    }
}

