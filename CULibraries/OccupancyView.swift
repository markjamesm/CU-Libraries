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
        VStack(alignment: .leading) {
        
            HStack() {
                Text("Webster Library:")
                    .font(.body)
            Spacer()
                Text("\(self.applogic.websterOccupancy)")
                    .font(.body)
                Spacer()
            }
            
            HStack {
                Text("Vanier Library:")
                    .font(.body)
                Spacer()
                Text("\(self.applogic.vanierOccupancy)")
                    .font(.body)
                Spacer()
            }
        }.padding()
    }
}

struct OccupancyView_Previews: PreviewProvider {
    static var previews: some View {
        
        OccupancyView().environmentObject(AppLogic())
    }
}
