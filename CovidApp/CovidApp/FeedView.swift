//
//  FeedView.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 4/3/21.
//

import SwiftUI
import Combine
import Foundation
import SwiftyJSON
import Alamofire


struct FeedView: View {
    
    @Environment(\.openURL) var openURL
    var country: Cases
    //@StateObject var news = NewsModel()
    var newsList = [News]()
    init(country: Cases) {
        self.country = country
        self.newsList = get_news(country: country)
    }
    
    var body: some View {
        
        NavigationView {
            Group {
                
                //List(news.newsList) { item in
                
                List(newsList) { item in
                    ArticleView(article: item)
                        .onTapGesture {
                            load(url: item.link)
                        }
                }
                .navigationTitle(Text("\(country.country) News"))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        //.onAppear(perform: self.get_news(country: country))
    }
    


func load(url: String?) {
    guard let link = url,
          let url = URL(string: link) else { return }
        
    openURL(url)
        
    }
    
    mutating func update_list(newsList: [News]) {
        self.newsList = newsList
    }
    
    mutating func get_news(country: Cases) -> [News] {
        
        var unsortedList = [News]() // Holds unsorted JSON data
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
            
            print(json["articles"])
            
            //var unsortedList = [News]() // Holds unsorted JSON data
            var temp: News // Saves each news
            
            for news in json["articles"] {
                //print(news.1["title"])
                // generates temp file
                temp = News(link: news.1["link"].stringValue, title: news.1["title"].stringValue, country: news.1["country"].stringValue, media: news.1["media"].stringValue, date: news.1["clean_url"].stringValue, source: news.1["rights"].stringValue)
                unsortedList.append(temp) // adds temp file into unsorted list
            }
            
            
            //update_list(newsList: unsortedList)
            newsList = unsortedList
        }
        //print(newsList)
        return unsortedList
    }
    
}



struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(country: Cases.dummy)
    }
}
