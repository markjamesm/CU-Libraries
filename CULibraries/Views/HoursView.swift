//
//  HoursView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-17.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

struct HoursView: View {
    
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
        VStack {
        HeaderView()
        NavigationView {
                   
            List(applogic.hours) { item in
                HStack{
                    Text(item.service)
                        .font(.body)
                    .frame(alignment: .leading)
                       // .padding()
                Spacer()
                Text(item.text)
                    .font(.body)
                    .padding()
           //     Spacer()
            .navigationBarTitle(Text("Today's Hours"))
            }//.id(UUID())
        }
        .padding()
        }
        .padding(.top, -25)
        FooterView()
        }
    }
}

struct HoursView_Previews: PreviewProvider {
    static var previews: some View {
        HoursView().environmentObject(AppLogic())
    }
}
