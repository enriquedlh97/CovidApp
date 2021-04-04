//
//  DataView.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 3/31/21.
//

import SwiftUI

struct DataView: View {
    
    var title: String
    var value: Double
    
    var body: some View {
        HStack {
            Text(title)
                .font(.Roboto(size: 20))
            Spacer()
            //Text(String(format: "%0.0f", value))
            Text(add_comma(value: value))
                .font(.Roboto(size: 20))
        }
    }
    
    func add_comma(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        let formattedAmount = formatter.string(from: value as NSNumber)!
        print(formattedAmount)
        return formattedAmount
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(title: "Cases", value: 1000000)
    }
}
