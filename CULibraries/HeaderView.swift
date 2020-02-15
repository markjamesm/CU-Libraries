//
//  HeaderView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-15.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
             HStack {
                           Text("CU Libraries")
                               .font(.body)
                               .foregroundColor(Color.white)
                            .padding(.top)
                           Spacer()

                       }
             .padding()
                       .background(Color.init(.systemGreen))
             .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
        } .edgesIgnoringSafeArea(.top)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
