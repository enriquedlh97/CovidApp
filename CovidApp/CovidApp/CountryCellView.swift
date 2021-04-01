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
                    Text(country.country)
                        .font(.Roboto(size: 24))
                    KFImage(URL(string:  country.flag)!)
                        .resizable()
                        //.scaledToFit()
                        .frame(width: 120, height: 69)
                        .padding(.top, -2)
                        .cornerRadius(6)
                        .overlay(RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.black, lineWidth: 1)
                        )
                }
                // Right side
                VStack {
                    Spacer()
                    DataView(title: "Cases", value: country.cases)
                    DataView(title: "Deaths", value: country.deaths)
                    DataView(title: "Recovered", value: country.recovered)
                    Spacer()
                }
            }
            //.padding(.horizontal, 20)
        }
    }
}

struct CountryCellView_Previews: PreviewProvider {
    static var previews: some View {
        CountryCellView(country: Cases.dummy)
    }
}
