//
//  OccupancyView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-13.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

struct OccupancyView: View {
    
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
       
        VStack {
        
            VStack(alignment: .leading) {
        
            HStack {
                Text("Webster Library")
                    .font(.headline)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(self.applogic.websterOccupancy)")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .padding()
            .background(Color.init(.systemBlue))
            .cornerRadius(20, corners: [.topLeft, .topRight])
        //    .cornerRadius(30)
        //    Divider()
            HStack {
                Text("Vanier Library")
                    .font(.headline)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(self.applogic.vanierOccupancy)")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .padding()
            .background(Color.init(.systemGreen))
          //  .cornerRadius(30)
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            
            Spacer()
            
            VStack {
                HStack {
                      Text("Last Updated")
                          .font(.body)
                          .foregroundColor(Color.white)
                      Spacer()
                       Text("\(self.applogic.time)")
                          .padding()
                      Spacer()
                  }
                  .padding()
                  .background(Color.init(.systemBlue))
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            }
            
        }
    }
    }
}

struct OccupancyView_Previews: PreviewProvider {
    static var previews: some View {
        
        OccupancyView().environmentObject(AppLogic())
    }
}
