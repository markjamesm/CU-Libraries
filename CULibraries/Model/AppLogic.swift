/*
AppLogic.swift

CULibraries, an app to see the current occupancy of the Concordia University libraries in Montreal, Quebec.

Created by Mark-James M. using the Concordia Opendata API.

 https://github.com/opendataConcordiaU/documentation

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import Foundation

class AppLogic: ObservableObject {
    
    //State vartiables to interface with viewcontroller
    @Published var websterOccupancy = " "
    @Published var vanierOccupancy = " "
    @Published var greyNunsOccupancy = " "
    @Published var time = " "
    @Published var networkingError = " "
    @Published var libraryResources = [LibraryBookingElement]()

    
    // The function which gets the current library occupancy rates and then updates the published vars.
    func getOccupancyRates() {
        
      // Build the authentication credentials
      let credential = URLCredential(user: "301", password: "d9d477f3accfbf1f61937ba0f54b3782", persistence: .forSession)
      let protectionSpace = URLProtectionSpace.init(host: "opendata.concordia.ca", port: 443, protocol: "https", realm: "Protected", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
      URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

        // Build the request and get JSON from the Open Data API
        let urlString = "https://opendata.concordia.ca/API/v1/library/occupancy/"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            
            // Update our published var to display an error if there's a problem with the network
            // This needs to happen on the main thread, so lets put it inside the DispatchQueue
            DispatchQueue.main.async {
                
                self.networkingError = error?.localizedDescription ?? ""
            }
        }

        guard let data = data else { return }
        do {

        //Decode JSON data
        let libraryData = try? JSONDecoder().decode(LibraryData.self, from: data)
        
        //Get back to the main queue so we can publish our observable variables to view
        DispatchQueue.main.async {
            
            // No errors to report
            self.networkingError = ""
            
            // Write library occupancies to published variables so we can display them in our view
            // Since the JSON returns the occupancy as a string with decimal places, we need to split
            // everything after the decimal in an array and then store the first part of the array.
            self.websterOccupancy = libraryData?.webster.occupancy ?? "0"
            let websterA = self.websterOccupancy.components(separatedBy: ".")
            self.websterOccupancy = websterA[0]
                
            self.vanierOccupancy = libraryData?.vanier.occupancy ?? "0"
            let vanierA = self.vanierOccupancy.components(separatedBy: ".")
            self.vanierOccupancy = vanierA[0]
                
            // Grey Nuns occupancy, not used for now.
            //self.greyNunsOccupancy = libraryData?.greyNuns.occupancy ?? "0"
                
            // Method to update the time when the API was last called
            self.lastApiTime()
                
            }
        } catch let jsonError {
            print(jsonError)
        }
        }.resume()
    }
    
    // Method to get the list of library resources
    func getResourceList() {
        
        // Build the authentication credentials
            let credential = URLCredential(user: "301", password: "d9d477f3accfbf1f61937ba0f54b3782", persistence: .forSession)
            let protectionSpace = URLProtectionSpace.init(host: "opendata.concordia.ca", port: 443, protocol: "https", realm: "Protected", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
            URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

              // Build the request and get JSON from the Open Data API
              let urlString = "https://opendata.concordia.ca/API/v1/library/rooms/getRoomsList"
              guard let url = URL(string: urlString) else { return }
              
              URLSession.shared.dataTask(with: url) { (data, response, error) in
              if error != nil {
                  
                  // Update our published var to display an error if there's a problem with the network
                  // This needs to happen on the main thread, so lets put it inside the DispatchQueue
                  DispatchQueue.main.async {
                      
                      self.networkingError = error?.localizedDescription ?? ""
                  }
              }

              guard let data = data else { return }
              do {

              //Decode JSON data
                let libraryResources: LibraryBooking = try! JSONDecoder().decode(LibraryBooking.self, from: data)
              
              //Get back to the main queue so we can publish our observable variables to view
              DispatchQueue.main.async {
                  
                  // No errors to report
                  self.networkingError = ""
                  self.libraryResources = libraryResources
                
                  // For debug purposes only
                  // print([libraryResources])
                 
                  // Method to update the time when the API was last called
                  self.lastApiTime()
                      
                  }
                  
              } catch let jsonError {
                  print(jsonError)
              }
                  
              }.resume()
    }
    
    // Method to get the current time and store it as a published var
    func lastApiTime() {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "HH:mm:ss"
        self.time = format.string(from: date)
        
    }
    
}
