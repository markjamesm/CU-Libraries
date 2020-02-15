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
                
                let websterA = self.websterOccupancy.components(separatedBy: ".")
                self.websterOccupancy = websterA[0]
                
                self.vanierOccupancy = libraryData?.vanier.occupancy ?? "0"
                let vanierA = self.vanierOccupancy.components(separatedBy: ".")
                self.vanierOccupancy = vanierA[0]
                
                // Grey Nuns occupancy, not used for now.
                //self.greyNunsOccupancy = libraryData?.greyNuns.occupancy ?? "0"
                
                // Call our function to set the time the API was last called
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
