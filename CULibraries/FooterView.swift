//
//  FooterView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-15.
//  Copyright © 2020 Cymatica. All rights reserved.
//

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
