/*
MainView.swift

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

struct ContentView: View {
    
    // Create an EnvironmentObject so that we can access our AppLogic properties
    // from this view
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
        VStack() {
                
                TabView {
                    DashboardView()
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("Dashboard")
                        }

                    AvailabilityView()
                        .tabItem {
                            Image(systemName: "desktopcomputer")
                            Text("Computer Availabilities")
                        }
                }
                
            .onAppear {
            self.applogic.getOccupancyRates()
                
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

    // Preview mode on the phone
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppLogic())
    }
}
