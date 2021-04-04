//
//  GraphsView.swift
//  CovidApp
//
//  Created by Enrique Diaz de Leon Hicks on 4/3/21.
//

import SwiftUI
import SwiftUICharts

struct GraphsView: View {
    
    var country: Cases
    @StateObject var data: DataModel
    @State var cases = [(String, Double)]()
    @State var deaths = [(String, Double)]()
    @State var vaccines = [(String, Double)]()
    
    var body: some View {
        VStack {
            BarChartView(data: ChartData(values: cases), title: "Cases", style: Styles.barChartStyleNeonBlueLight, form: ChartForm.extraLarge, valueSpecifier: "%.0f")
            BarChartView(data: ChartData(values: deaths), title: "Deaths", style: Styles.barChartStyleOrangeLight, form: ChartForm.extraLarge, valueSpecifier: "%.0f")
            BarChartView(data: ChartData(values: vaccines), title: "Vaccines", style: Styles.barChartMidnightGreenLight, form: ChartForm.extraLarge, valueSpecifier: "%.0f")
        }
        // Makes sure that every time the screen appears the values are updated with the received paramters
        .onAppear {
            data.getHistory(country: country.iso) { (returned_cases, returned_deaths) in
                self.cases.append(contentsOf: returned_cases)
                self.deaths.append(contentsOf: returned_deaths)
            }
            data.getVaccines(country: country.iso) { (returned_vaccines) in
                self.vaccines.append(contentsOf: returned_vaccines)
            }
        }
    }
}

struct GraphsView_Previews: PreviewProvider {
    static var previews: some View {
        GraphsView(country: Cases.dummy, data: DataModel())
    }
}
