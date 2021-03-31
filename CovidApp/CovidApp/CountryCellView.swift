//
//  CountryCellView.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 3/30/21.
//

import SwiftUI
import Kingfisher

struct CountryCellView: View {
    
    var country: Cases // Recieves to display country data
    
    var body: some View {
        VStack{
            
            HStack {
                // Left side
                VStack {
                    KFImage(URL(string:  country.flag)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 69)
                }
                // Right side
                VStack {
                    Spacer()
                    HStack {
                        Text("Cases:")
                        Spacer()
                        Text(String(format: "%0.0f", country.cases))
                    }
                    HStack {
                        Text("Deaths:")
                        Spacer()
                        Text(String(format: "%0.0f", country.deaths))
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct CountryCellView_Previews: PreviewProvider {
    static var previews: some View {
        CountryCellView(country: Cases.dummy)
    }
}
