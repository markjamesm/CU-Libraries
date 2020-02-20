//
//  ReservationView.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-18.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import SwiftUI

struct ReservationView: View {
    
    @EnvironmentObject var applogic: AppLogic
    
    var body: some View {
        VStack {
        //    NavigationView {
            HStack{
                Spacer()
                Text("Booking Start")
                Spacer()
                Text("Booking End")
                Spacer()
            }.padding()
                   
            List(applogic.libraryReservation) { item in
            HStack{
                
                Text(item.startDate)
                .font(.body)
                .frame(alignment: .leading)

                Spacer()
                Text(item.endDate)
                .font(.body)
            }
           // .navigationBarTitle(Text("Reservations"))
            }
                Spacer()
         //   }
    //    FooterView()
        }
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
