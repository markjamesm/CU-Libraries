//
//  ImageView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-13.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        HStack {
        Image("webster-library")
            .resizable()
            .scaledToFit()
            .cornerRadius(12) // Inner corner radius
            .padding(8) // Width of the border
            .background(Color(.brown))
            .cornerRadius(12)
            
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
