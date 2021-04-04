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
    @StateObject var cases: DataModel
    
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
            HStack {
            NavigationLink(destination: GraphsView(country: country, cases: cases),
                           label: {
                            VStack {
                                Text("Graphs")
                                    .font(.Roboto(size: 24))
                                Image(systemName: "chart.bar.fill")
                            }
                           })
            Spacer()
                NavigationLink(destination: FeedView(country: country),
                           label: {
                                VStack {
                                    Text("News")
                                        .font(.Roboto(size: 24))
                                    Image(systemName: "newspaper")
                                }
                           })
            }.padding(.horizontal, 100)
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
        CountryView(country: Cases.dummy, cases: DataModel())
    }
}
