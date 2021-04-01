//
//  ContentView.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 3/28/21.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var cases = DataModel() // wrapper is used to create the reference in this view to the data model and keep it alive for use in the view and other views.
    // Essentially with the wrapper we can use the variable in various viwes without
    // having to create it externally to SwitUI and inject it in.
    // It makes sure the object doe snot get destroyed when the view updates
    
    
    var body: some View {
        NavigationView {
            VStack {
                List(cases.casesList) { country in // iterate over country list which is casesList and the list is order by most cases to less cases
                    NavigationLink(destination: CountryView(country: country), label: {CountryCellView(country: country)})
                }
                .listStyle(PlainListStyle())
            }
            .padding(.bottom,20)
            .navigationBarTitle("COVID-19")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
