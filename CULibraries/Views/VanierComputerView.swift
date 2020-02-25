/*
VanierComputerView.swift

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

struct VanierComputerView: View {

    @EnvironmentObject var applogic: AppLogic

    var body: some View {

        List {

            Section(header: Text("Laptops and Tablets")) {
                Text("Laptops: \(self.applogic.libraryComputers?.vanier.laptops ?? "") available")
                Text("Tablets: \(self.applogic.libraryComputers?.vanier.tablets ?? "") available")
                }

            Section(header: Text("Computer Labs")) {
            Text("VL-122: \(self.applogic.libraryComputers?.vanier.desktops.vl122 ?? "") desktops available")
            Text("VL-201: \(self.applogic.libraryComputers?.vanier.desktops.vl201 ?? "") desktops available")
            }

            }.listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Vanier Library"), displayMode: .inline)
    }
}

struct VanierComputerView_Previews: PreviewProvider {
    static var previews: some View {
        VanierComputerView().environmentObject(AppLogic())
    }
}
