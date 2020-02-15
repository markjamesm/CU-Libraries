//
//  HeaderView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-13.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

// Define the rounded corner shape so we can use our corner specific rounding function

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

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
           // .cornerRadius(25)
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])

        ImageView()
            .padding()
            Spacer()
            OccupancyView()
            Spacer()
        }
        }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView().environmentObject(AppLogic())
    }
}
