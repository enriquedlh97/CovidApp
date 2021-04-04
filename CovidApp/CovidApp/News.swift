//
//  Cases.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 3/29/21.
//

import SwiftUI

// Identifiable is used when asigning a type of an id to an the struct
// it is telling swift that it can be uniquely identifiable
struct News: Identifiable {
    // Used to hold the country-specific data gotten form API
    
    var id = UUID() // Lets swift assign and id automatically
    var link: String? // Link to news
    var title: String? // title of news
    var country: String?  // COuntry if news
    var media: String? // Image
    var date: String? //date of news
    var source: String?
    
}

// Generate dummy data
extension News {
    
    static let dummy = News(link: "https://economictimes.indiatimes.com/news/newsblogs/coronavirus-india-cases-update-covid-vaccine-latest-news-march-29/liveblog/81741244.cms", title: "Covid Live Updates: India reports 68,020 new Covid-19 cases", country: "IN", media: "https://img.etimg.com/thumb/msid-81741244,width-600,resizemode-4,imglength-217508/news/newsblogs/coronavirus-india-cases-update-covid-vaccine-latest-news-march-29.jpg", date: "2021-03-28 08:00:00", source: "indiatimes.com")
    
}
