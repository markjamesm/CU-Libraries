//
//  ResourceListView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-16.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

struct ResourceListView: View {
    
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
        
        NavigationView {
                   
            List(applogic.libraryResources) { item in
                  
            HStack {
            Text(item.name)
            }
            .navigationBarTitle(Text("Library Resources"))
            }
        }.padding(.top, -40)
    }
}

struct ResourceListView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceListView().environmentObject(AppLogic())
    }
}
