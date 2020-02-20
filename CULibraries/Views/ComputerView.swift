//
//  ComputerView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-19.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

struct ComputerView: View {
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
        VStack {
             //   NavigationView {
                    
                   // NavigationLink(destination: ReservationView()) {
            Text(self.applogic.)
            
            
                    Spacer()
           // }
            FooterView()
        }
         .onAppear {
           
               }
    }
}

struct ComputerView_Previews: PreviewProvider {
    static var previews: some View {
        ComputerView()
    }
}

