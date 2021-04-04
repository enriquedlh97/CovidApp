//
//  DataModel.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 3/29/21.
//

import SwiftUI
import Alamofire
import SwiftyJSON

class DataModel: ObservableObject {
    
    @Published var casesList = [Cases]() // Contains list of all cases in countries
    init() {
        getData()
    }
    
    func getData() {
        
        let URL = "https://disease.sh/v3/covid-19/countries"
        
        // Makes request to above URL and reads the data via .responseData
        AF.request(URL).responseData { data in // data is going to contain all the data gotten from response
            
            // converts data from reponse into JSON
            let json = try! JSON(data: data.data!) // try is to catch exceptions inc ase it is not possible
            
            print(json.count)
            
            var unsortedList = [Cases]() // Holds unsorted JSON data
            var temp: Cases // Saves each case
            
            for country in json {
                // generates temp file
                temp = Cases(country: country.1["country"].stringValue,
                             iso: country.1["countryInfo"]["iso3"].stringValue,
                             lat: country.1["countryInfo"]["lat"].floatValue,
                             long: country.1["countryInfo"]["long"].floatValue,
                             flag: country.1["countryInfo"]["flag"].stringValue,
                             cases: country.1["cases"].doubleValue,
                             deaths: country.1["deaths"].doubleValue,
                             recovered: country.1["recovered"].doubleValue,
                             active: country.1["active"].doubleValue,
                             critical: country.1["critical"].doubleValue,
                             population: country.1["population"].doubleValue,
                             continent: country.1["continent"].stringValue)
                unsortedList.append(temp) // adds temp file into unsorted list
            }
            
            // sorts the unsroted array
            self.casesList = unsortedList.sorted {
                $0.cases > $1.cases // indicates ordering from most cases to less cases
            }
            
        }
        
        
    }
    
    // The @escaping decorator indicates that it generates the data in an asynchronous manner
    func getHistory(country: String, handler: @escaping(_ cases: [(String,Double)], _ deaths: [(String,Double)]) -> ()) {
        
        let URL = "https://disease.sh/v3/covid-19/historical/\(country)?lastdays=70"
        print("url: \(URL)")
        
        AF.request(URL).responseData { [self] data in
            
            let json = try! JSON(data: data.data!)
            
            print(json)
            var unsortedCases = [(String, Double)]()
            var unsortedDeaths = [(String, Double)]()
            var sortedCases = [(String, Double)]()
            var sortedDeaths = [(String, Double)]()
            var returnedCases = [(String, Double)]()
            var returnedDeaths = [(String, Double)]()
            for hist in json {
                if hist.0 == "timeline" {
                    // adds each element for every day t the unsorted array. Here we are saving the data to use it later
                for value in hist.1["cases"] {
                    unsortedCases.append((self.dateToNewDate(value.0), value.1.doubleValue))
                }
                sortedCases = unsortedCases.sorted {
                    $0.0 < $1.0
                }
                    // This adds the cases in multiples of seven days so that our graphs can be displayed in weeks
                for i in 0..<sortedCases.count {
                    if i % 7 == 0 {
                        returnedCases.append(sortedCases[i])
                    }
                }
                for value in hist.1["deaths"] {
                    unsortedDeaths.append((self.dateToNewDate(value.0), value.1.doubleValue))
                }
                sortedDeaths = unsortedDeaths.sorted {
                    $0.0 < $1.0
                }
                for i in 0..<sortedDeaths.count {
                    if i % 7 == 0 {
                        returnedDeaths.append(sortedDeaths[i])
                    }
                }
                }
            }
            
            handler(returnedCases, returnedDeaths)
        }
    }
    
    func getVaccines(country: String, handler: @escaping(_ vaccines: [(String,Double)]) -> ()) {
        
        let URL = "https://disease.sh/v3/covid-19/vaccine/coverage/countries/\(country)?lastdays=70"
        print("url: \(URL)")
        
        AF.request(URL).responseData { data in
            
            let json = try! JSON(data: data.data!)
            
            print(json)
            var unsortedVaccines = [(String, Double)]()
            var sortedVaccines = [(String, Double)]()
            var returnedVaccines = [(String, Double)]()
            
            for hist in json {
                if hist.0 == "timeline" {
                    print("Vacunas: \(hist)")
                    for value in hist.1 {
                        unsortedVaccines.append((self.dateToNewDate(value.0), value.1.doubleValue))
                    }
                    print("Count: \(unsortedVaccines.count)")
                    sortedVaccines = unsortedVaccines.sorted {
                        $0.0 < $1.0
                    }
                    for i in 0..<sortedVaccines.count {
                        if i % 7 == 0 {
                            returnedVaccines.append(sortedVaccines[i])
                        }
                    }
                }
                
            }
            
            handler(returnedVaccines)
        }
    }
    
    
    private func dateToNewDate(_ date: String) -> String {
        let i = date.firstIndex(of: "/")
        var day  = date.prefix(upTo: i!)
        if day.count == 1 {
            day = "0" + day
        }
        let mid = date.index(i!, offsetBy: 1)
        let m = date.lastIndex(of: "/")
        var month = date[mid..<m!]
        if month.count == 1 {
            month = "0" + month
        }
        let mid1 = date.index(m!, offsetBy: 1)
        let year = date.suffix(from: mid1)
        return day + "/" + month + "/" + year
    }
}

