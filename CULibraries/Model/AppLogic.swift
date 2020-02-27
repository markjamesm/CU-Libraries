/*
AppLogic.swift

CULibraries, an Open Source Concordia University libraries app.
Created using the Concordia Opendata API.

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

    let apiKey = ApiKey()

    //State variables to interface with viewcontroller
    @Published var websterOccupancy = " "
    @Published var websterOccupancyInt = 0
    @Published var vanierOccupancy = " "
    @Published var vanierOccupancyInt = 0
    @Published var greyNunsOccupancy = " "
    @Published var time = " "
    @Published var occupancyNetworkErrorMessage = " "
    @Published var websterOccupancyError = " "
    @Published var vanierOccupancyError = " "
    @Published var networkingError: Bool = false
    @Published var libraryResources = [LibraryBookingElement]()
    @Published var hours = [LibraryHour]()
    @Published var libraryReservation = [LibraryReservationElement]()
    @Published var resourceID = "53"
    @Published var scheduleID = "1"
    @Published var libraryComputers: LibraryComputers?
    @Published var jsonError = " "
    @Published var reservationNetworkErrorMessage = " "

    // The function which gets the current library occupancy rates and then updates the published vars.
    func getOccupancyRates() {

      // Build the authentication credentials
      let credential = URLCredential(user: apiKey.apiUser, password: apiKey.apiKey, persistence: .forSession)
      let protectionSpace = URLProtectionSpace.init(host: "opendata.concordia.ca", port: 443, protocol: "https", realm: "Protected", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
      URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

        // Build the request and get JSON from the Open Data API
        let urlString = "https://opendata.concordia.ca/API/v1/library/occupancy/"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
        if error != nil {

            // Update our published var to display an error if there's a problem with the network
            // This needs to happen on the main thread, so lets put it inside the DispatchQueue
            DispatchQueue.main.async {

                self.networkingError = true
                self.occupancyNetworkErrorMessage = error?.localizedDescription ?? ""
                self.websterOccupancyInt = 0
                self.vanierOccupancyInt = 0
                self.websterOccupancyError = "Insufficient data to provide Webster library occupancy. Please try again later"
                self.vanierOccupancyError = "Insufficient data to provide Vanier library occupancy. Please try again later"
            //  print(self.networkingErrorMessage)
            }
        }

        guard let data = data else { return }
        do {

        //Decode JSON data
        let libraryData = try? JSONDecoder().decode(LibraryData.self, from: data)

        //Get back to the main queue so we can publish our observable variables to view
        DispatchQueue.main.async {

            // No errors to report
            self.occupancyNetworkErrorMessage = " "

            // Write library occupancies to published variables so we can display them in our view
            // Since the JSON returns the occupancy as a string with decimal places, we need to split
            // everything after the decimal in an array and then store the first part of the array.
            // Then we convert to int to perform some logic checks.
            self.websterOccupancy = libraryData?.webster.occupancy ?? "0"
            let websterA = self.websterOccupancy.components(separatedBy: ".")
            let websterInt = Int(websterA[0]) ?? 0
           // let websterInt = -10

            // Check to see if the occupancy is positive. If not display zero and a message.
            if self.isOccupancyPositive(occupancy: websterInt) == true {
                self.websterOccupancyInt = websterInt
                self.websterOccupancyError = ""
            }
            if self.isOccupancyPositive(occupancy: websterInt) == false {
                self.websterOccupancyError = "Insufficient data to provide Webster library occupancy. Please try again later."
                self.websterOccupancyInt = 0
            }

            self.vanierOccupancy = libraryData?.vanier.occupancy ?? "0"
            let vanierA = self.vanierOccupancy.components(separatedBy: ".")
            let vanierInt = Int(vanierA[0]) ?? 0
           // let vanierInt = -3

            if self.isOccupancyPositive(occupancy: vanierInt) == true {
                self.vanierOccupancyInt = vanierInt
                self.vanierOccupancyError = ""
            }

            if self.isOccupancyPositive(occupancy: vanierInt) == false {
                self.vanierOccupancyError = "Insufficient data to provide Vanier library occupancy. Please try again later."
                self.vanierOccupancyInt = 0

            }

            // This case is when both libraries have occupancy data < 0
            if  self.isOccupancyPositive(occupancy: vanierInt) == false && self.isOccupancyPositive(occupancy: vanierInt) == false {
                self.websterOccupancyError = "Insufficient data to provide library occupancies. Please try again later."
                self.websterOccupancyInt = 0
                self.vanierOccupancyInt = 0
                self.vanierOccupancyError = " "

            }

            // Grey Nuns occupancy, not used for now.
            //self.greyNunsOccupancy = libraryData?.greyNuns.occupancy ?? "0"

            // Method to update the time when the API was last called
            self.lastApiTime()

            }
        } catch let jsonError {
       //     print(jsonError)
            self.jsonError = jsonError as? String ?? "Error"
        }
        }.resume()
    }

    func isOccupancyPositive(occupancy: Int) -> Bool {

        if occupancy < 0 {
            return false
        }
        if occupancy >= 0 {
            return true
        }
        return false
    }

    // Method to get the library hours for today's date. The date is set by passing todaysDate() as date in the
         // call
    func getLibraryHours(date: String) {

        // Build the authentication credentials
        let credential = URLCredential(user: apiKey.apiUser, password: apiKey.apiKey, persistence: .forSession)
        let protectionSpace = URLProtectionSpace.init(host: "opendata.concordia.ca", port: 443, protocol: "https", realm: "Protected", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
        URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

        // Build the request and get JSON from the Open Data API
        let baseURL = "https://opendata.concordia.ca/API/v1/library/hours/"
        let urlString = baseURL + date
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
        if error != nil {

            // Update our published var to display an error if there's a problem with the network
            // This needs to happen on the main thread, so lets put it inside the DispatchQueue
            DispatchQueue.main.async {

            //   self.networkingErrorMessage = error?.localizedDescription ?? ""
            //         self.networkingError = true
            }
        }

        guard let data = data else { return }
        do {

        //Decode JSON data
            let hours: LibraryHours = try! JSONDecoder().decode(LibraryHours.self, from: data)

            //Get back to the main queue so we can publish our observable variables to view
            DispatchQueue.main.async {

                // No errors to report
                // self.networkingErrorMessage = ""
                self.hours = hours

                // Method to update the time when the API was last called
                // Need to store this as a separate value so its distinguishable from the getResourceList() invocation
                self.lastApiTime()

                }

            } catch let jsonError {
            print(jsonError)
            }

        }.resume()
    }

    // Method to fetch computer availabilities
    func getComputerUse() {

        // Build the authentication credentials
            let credential = URLCredential(user: apiKey.apiUser, password: apiKey.apiKey, persistence: .forSession)
            let protectionSpace = URLProtectionSpace.init(host: "opendata.concordia.ca", port: 443, protocol: "https", realm: "Protected", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
            URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

              // Build the request and get JSON from the Open Data API
              let urlString = "https://opendata.concordia.ca/API/v1/library/computers/"
              guard let url = URL(string: urlString) else { return }

              URLSession.shared.dataTask(with: url) { (data, _, error) in
              if error != nil {

                  // Update our published var to display an error if there's a problem with the network
                  // This needs to happen on the main thread, so lets put it inside the DispatchQueue
                  DispatchQueue.main.async {

            //          self.networkingErrorMessage = error?.localizedDescription ?? ""
//                      self.networkingError = true
                  }
              }

              guard let data = data else { return }
              do {

              //Decode JSON data
                let libraryComputers: LibraryComputers = try! JSONDecoder().decode(LibraryComputers.self, from: data)

              //Get back to the main queue so we can publish our observable variables to view
              DispatchQueue.main.async {

                // No errors to report
           //     self.networkingErrorMessage = ""
                self.libraryComputers = libraryComputers

                  // For debug purposes only
                  // print([libraryResources])

                  // Method to update the time when the API was last called
                  // Need to store this as a separate value so its distinguishable from the getResourceList() invocation
                  // self.lastApiTime()

                  }

              } catch let jsonError {
                  print(jsonError)
              }

              }.resume()
    }

    // Both these methods could go in a separate time file and sit in a struct for modularity.

    // Method to get the current time and store it as a published var
 func lastApiTime() {

        let date = Date()
        let format = DateFormatter()
        //  format.dateStyle = .short
        format.timeStyle = .short
        self.time = format.string(from: date)

    }

    // Method to pass the current date to the LibraryHours method
   func todaysDate() -> String {

        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let time = format.string(from: date)
        return time

    }
   
   // Method to get the list of library resources
   func getResourceList() {
       
       // Build the authentication credentials
           let credential = URLCredential(user: apiKey.apiUser, password: apiKey.apiKey, persistence: .forSession)
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
                     
                //     self.networkingErrorMessage = error?.localizedDescription ?? ""
               //      self.networkingError = true
                 }
             }

             guard let data = data else { return }
             do {

             //Decode JSON data
               let libraryResources: LibraryBooking = try! JSONDecoder().decode(LibraryBooking.self, from: data)
             
             //Get back to the main queue so we can publish our observable variables to view
             DispatchQueue.main.async {
                 
                 // No errors to report
               //  self.networkingErrorMessage = ""
                self.libraryResources = libraryResources
           
                     
                 }
                 
             } catch let jsonError {
                 print(jsonError)
             }
                 
             }.resume()
   }

   func getReservation(resourceID: String, scheduleID: String) {
          
          // Build the authentication credentials
    let credential = URLCredential(user: apiKey.apiUser, password: apiKey.apiKey, persistence: .forSession)
              let protectionSpace = URLProtectionSpace.init(host: "opendata.concordia.ca", port: 443, protocol: "https", realm: "Protected", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
              URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

                // Build the request and get JSON from the Open Data API
                let baseURL = "https://opendata.concordia.ca/API/v1/library/rooms/getRoomReservations/"
                let urlString = baseURL + "\(resourceID)/" + scheduleID
                guard let url = URL(string: urlString) else { return }
                
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    
                    // Update our published var to display an error if there's a problem with the network
                    // This needs to happen on the main thread, so lets put it inside the DispatchQueue
                    DispatchQueue.main.async {
                        
                     //   self.reservationErrorMessage = error?.localizedDescription ?? ""
                   //     self.networkingError = true
                    }
                }

                guard let data = data else { return }
                do {

                //Decode JSON data
                  let libraryReservations: LibraryReservation = try! JSONDecoder().decode(LibraryReservation.self, from: data)
                
                //Get back to the main queue so we can publish our observable variables to view
                DispatchQueue.main.async {
                    
                  // No errors to report
                  self.libraryReservation = libraryReservations
                        
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                    
                }.resume()
      }
}
