//
//  AppLogic.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-09.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import Foundation

class AppLogic: ObservableObject {
    
    //State vartiables to interface with viewcontroller
    @Published var websterOccupancy = " "
    @Published var vanierOccupancy = " "
    @Published var greyNunsOccupancy = " "

    func getOccupancyRates() {
        
      // Build the authentication credentials
      let credential = URLCredential(user: "169", password: "fd896d1fc8a3fcdb8c0d29bab51720e3", persistence: .forSession)
      let protectionSpace = URLProtectionSpace.init(host: "opendata.concordia.ca", port: 443, protocol: "https", realm: "Protected", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
      URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

        // Build the request and get JSON
        let urlString = "https://opendata.concordia.ca/API/v1/library/occupancy/"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!.localizedDescription)
        }

        guard let data = data else { return }
        do {

        //Decode JSON data
        let libraryData = try? JSONDecoder().decode(LibraryData.self, from: data)
        
            //Get back to the main queue so we can publish our observable variables to view
            DispatchQueue.main.async {
                
                // Write library occupancies to published variables so we can display them in our view
                self.websterOccupancy = libraryData?.webster.occupancy ?? "0"
                self.vanierOccupancy = libraryData?.vanier.occupancy ?? "0"
                self.greyNunsOccupancy = libraryData?.greyNuns.occupancy ?? "0"
                
            }
            
        } catch let jsonError {
            print(jsonError)
        }
            
        }.resume()
    }
}
