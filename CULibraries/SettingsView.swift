//
//  SettingsView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-09.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                    HStack {
                        Text("CU Library Occupancy")
                           .font(.title)
                            .padding(.top, 30)
                        Text("\(")
                    }
                   
                    HStack {
                        Image("webster-library")
                           .resizable()
                           .scaledToFit()
                           .cornerRadius(12) // Inner corner radius
                           .padding(8) // Width of the border
                           .background(Color(red: 147/255, green: 36/255, blue: 57/255, opacity: 1.0))
                            .cornerRadius(12)
                    } // Outer corner radius
            }.padding()
               
            HStack {
                    Text("Webster Library:")
                }
                HStack {
                    Text("Vanier Library:")
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
