//
//  Cases.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 3/29/21.
//

import SwiftUI

// Identifiable is used when asigning a type of an id to an the struct
// it is telling swift that it can be uniquely identifiable
struct Cases: Identifiable {
    // Used to hold the country-specific data gotten form API
    
    var id = UUID() // Lets swift assign and id automatically
    var country: String // Holds the name of a country
    var iso: String // Used to hold a country ID
    var lat: Float  // latitude
    var long: Float // longitude
    var flag: String //url with flag of country
    var cases: Double
    var deaths: Double
    var recovered: Double
    var active: Double
    var critical: Double
    var population: Double
    var continent: String
    
}

// Generate dummy data
extension Cases {
    
    static let dummy = Cases(country: "Argentina", iso: "ARG", lat: -34, long: -64, flag: "https://disease.sh/assets/img/glags/ar.flag", cases: 2278115, deaths: 55092, recovered: 2056472, active: 166551, critical: 3585, population: 45498383, continent: "South America")
    
}
