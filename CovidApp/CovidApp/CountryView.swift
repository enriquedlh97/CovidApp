//
//  CountryView.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 3/31/21.
//

import SwiftUI
import Kingfisher

struct CountryView: View {
    
    // Received parameter
    var country: Cases
    
    var body: some View {
        VStack {
            KFImage(URL(string: country.flag)!)
                .resizable()
                .frame(width: 240, height: 138)
                .overlay(RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.black, lineWidth: 1))
                .padding(.top, 30)
            VStack {
                DataView(title: "Cases", value: country.cases)
                DataView(title: "Deaths", value: country.deaths)
                DataView(title: "Recovered", value: country.recovered)
                DataView(title: "Active", value: country.active)
                DataView(title: "Critical", value: country.critical)
            }
            .padding(.horizontal, 80)
            Spacer()
            MapView(country: country)
                .padding(.bottom, 40)
        }
        .navigationBarTitle(country.country)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: Cases.dummy)
    }
}
