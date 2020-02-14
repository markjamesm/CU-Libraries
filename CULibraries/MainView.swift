//
//  SettingsView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-09.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // Create an EnvironmentObject so that we can access our AppLogic properties
    // from this view
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
        VStack() {
            HeaderView()
            VStack() {
            ImageView()
            OccupancyView()
                }.padding()
        .onAppear {
            self.applogic.getOccupancyRates()
        }
        }
    }
}

    // Preview mode on the phone
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppLogic())
    }
}
