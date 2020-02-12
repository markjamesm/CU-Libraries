//
//  AppLogic.swift
//  CULibraries
//
//  Created by Mark-James McDougall on 2020-02-09.
//  Copyright © 2020 Cymatica. All rights reserved.
//

import Foundation

class AppLogic: ObservableObject {
    
    @Published var websterOccupancy = " "
    @Published var vanierOccupancy = " "
    @Published var greyNunsOccupancy = " "

    func getOccupancyRates() {
        
      let credential = URLCredential(user: "169", password: "fd896d1fc8a3fcdb8c0d29bab51720e3", persistence: .forSession)
      let protectionSpace = URLProtectionSpace.init(host: "opendata.concordia.ca", port: 443, protocol: "https", realm: "Protected", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
      URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

       
        let urlString = "https://opendata.concordia.ca/API/v1/library/occupancy/"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!.localizedDescription)
        }

        guard let data = data else { return }
        do {

        //Decode data
        let libraryData = try? JSONDecoder().decode(LibraryData.self, from: data)
            
          //  print("This is: \(libraryData?.webster.occupancy)")
         //   print(data)
         //   print(response)
         //   print(error)

            //Get back to the main queue
            DispatchQueue.main.async {

                self.websterOccupancy = libraryData?.webster.occupancy as! String
                self.vanierOccupancy = libraryData?.vanier.occupancy as! String
                self.greyNunsOccupancy = libraryData?.greyNuns.occupancy as! String
                
            }

        } catch let jsonError {
            print(jsonError)
        }
        }.resume()
    }
}
