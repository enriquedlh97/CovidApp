//
//  FeedView.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 4/3/21.
//

import SwiftUI
import Combine

struct FeedView: View {
    
    @Environment(\.openURL) var openURL
    var country: Cases
    @StateObject var news = NewsModel()
    init(country: Cases) {
        self.country = country
        
    }
    
    
    var body: some View {
        
        NavigationView {
            Group {
                
                //List(news.newsList) { item in
                
                List(news.newsList) { item in
                    ArticleView(article: item)
                        .onTapGesture {
                            load(url: item.link)
                        }
                }
                .navigationTitle(Text("\(country.country) News"))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        //.onAppear(perform: news.get_news)
    }
    


func load(url: String?) {
    guard let link = url,
          let url = URL(string: link) else { return }
        
    openURL(url)
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(country: Cases.dummy)
    }
}
