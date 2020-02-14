//
//  HeaderView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-13.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

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

        Spacer()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
