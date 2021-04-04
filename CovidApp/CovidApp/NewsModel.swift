//
//  NewsModel.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 4/3/21.
//

import SwiftUI
import Foundation
import SwiftyJSON
import Alamofire

class NewsModel: ObservableObject {
    
    @Published var newsList = [News]() // Contains list of all news in countries
    var country: Cases
    init() {
        self.country = Cases.dummy
    }
    
    func get_news(country: Cases) {
        
        
        let iso:[String:String] = ["ARG":"AR", "USA":"US"]
        
        let headers: HTTPHeaders = [
                    "x-rapidapi-key": "f8ebd067cdmsh4cd4c53f3ae1900p16eb67jsn87aeea2d0e14",
                    "x-rapidapi-host": "covid-19-news.p.rapidapi.com"
                ]
        
        //let parameters = ["lang": "en", "country":iso[country.iso]]
        let parameters = ["country":iso[country.iso]]
        
        print(parameters)
        
        let URL = "https://covid-19-news.p.rapidapi.com/v1/covid?q=covid&lang=en&media=True"
        
        // Makes request to above URL and reads the data via .responseData
        AF.request(URL, parameters: parameters, headers: headers).responseData { data in // data is going to contain all the data gotten from response
            
            // converts data from reponse into JSON
            let json = try! JSON(data: data.data!) // try is to catch exceptions inc ase it is not possible
            
            //print(json)
            
            var unsortedList = [News]() // Holds unsorted JSON data
            var temp: News // Saves each news
            
            for news in json["articles"] {
                //print(news.1["title"])
                // generates temp file
                temp = News(link: news.1["link"].stringValue, title: news.1["title"].stringValue, country: news.1["country"].stringValue, media: news.1["media"].stringValue, date: news.1["clean_url"].stringValue, source: news.1["rights"].stringValue)
                unsortedList.append(temp) // adds temp file into unsorted list
            }
            
            self.newsList = unsortedList
            
        }
        
    }
    
/*    func format_date(value: String) -> Date {
        let datetimeArr = value.split{$0 == " "}.map(String.init)
        let str = datetimeArr[0]
        let dateFormatter = DateFormatter()
        return dateFormatter.date(from: str)!
    }
   */
}
