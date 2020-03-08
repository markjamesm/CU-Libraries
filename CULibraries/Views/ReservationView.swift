/*
Reservation View.swift

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

struct ReservationView: View {

    @EnvironmentObject var applogic: AppLogic
    
    internal var resourceID: String
    internal var scheduleID: String
    internal var name: String

    var body: some View {
        VStack {
/*
            HStack{
                Spacer()
                Text(self.name)
                    .font(.headline)
                Spacer()
            }.padding()
            HStack {
                Text("Booking Start")
                    .padding()
                Spacer()
                Text("Booking End")
                Spacer()
            }

            List(applogic.libraryReservation) { item in
            HStack {
                Text("\(item.startDate)")
                .font(.body)
                .frame(alignment: .leading)

                Spacer()
                Text("\(item.endDate)")
                .font(.body)
            }
            } */
                Spacer()
        }.onAppear {
            self.applogic.getReservation(resourceID: self.resourceID, scheduleID: self.scheduleID)
            
           // print(self.resourceID)
           // print(self.scheduleID)
            }
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(resourceID: "51", scheduleID: "1", name: "Test").environmentObject(AppLogic())
    }
}
