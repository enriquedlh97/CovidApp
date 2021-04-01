//
//  MapView.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 3/31/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var country: Cases
    // Defaul value for London location
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
                .frame(width: 400, height: 300) // Map size
        }
        // This makes sure that when this screen appears, the region variable is updated with the data
        // received from the country variable
        .onAppear {
            region = MKCoordinateRegion(center:
                                            CLLocationCoordinate2D(latitude: CLLocationDegrees(Float(country.lat)),
                                                                   longitude: CLLocationDegrees(Float(country.long))),
                                        // Indicates the zoom on map
                                        span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(country: Cases.dummy, region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)))
    }
}
