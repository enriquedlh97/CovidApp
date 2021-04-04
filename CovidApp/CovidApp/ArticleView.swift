//
//  ArticleView.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 4/3/21.
//

import SwiftUI
import URLImage

struct ArticleView: View {
    
    let article: News
    
    var body: some View {
        HStack {
            
            if let imgUrl = article.media,
               let url = URL(string: imgUrl) {
                
                URLImage(url: url,
                         options: URLImageOptions(
                            identifier: article.id.uuidString,
                            cachePolicy:
                                .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                         ),
                         failure: { error, _ in
                            PlaceHolderImageView()
                         },
                         content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                         })
                    .frame(width: 100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100)
                    .cornerRadius(10)
                // Build asynchronous image object
            } else {
                PlaceHolderImageView()
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .semibold))
                Text(article.source ?? "N/A")
                    .foregroundColor(.blue)
                    
                    //.foregroundColor(.white)
                    //.background(Color.blue)
                    .font(.footnote)
                    .bold()
                    .frame(width: 100, height: 20, alignment: .leading)
                    
                
                if let date = article.date {
                    HStack {
                        //Text(date, style: .date)
                        Text(date)
                            .foregroundColor(.gray)
                            .font(.system(size: 12, weight: .regular))
                        /*Divider().background(Color.blue)
                        Text(date, style: .time)
                            .foregroundColor(.gray)
                            .font(.system(size: 12, weight: .regular))*/
                    }.frame(height:20)
                }
                Divider().frame(height: 5).background(Color.blue)
            }
        }
    }
}

struct PlaceHolderImageView: View {
    
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: News.dummy)
            .previewLayout(.sizeThatFits)
    }
}
