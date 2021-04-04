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
    @StateObject var cases: DataModel
    @State var casesArr = [(String, Double)]()
    @State var deathsArr = [(String, Double)]()
    @State var vaccinesArr = [(String, Double)]()
    
    var body: some View {
        VStack {
            BarChartView(data: ChartData(values: casesArr), title: "Cases", style: Styles.barChartStyleNeonBlueLight, form: ChartForm.extraLarge, valueSpecifier: "%.0f")
            BarChartView(data: ChartData(values: deathsArr), title: "Deaths", style: Styles.barChartStyleOrangeLight, form: ChartForm.extraLarge, valueSpecifier: "%.0f")
            BarChartView(data: ChartData(values: vaccinesArr), title: "Vaccines", style: Styles.barChartMidnightGreenLight, form: ChartForm.extraLarge, valueSpecifier: "%.0f")
        }
        // Makes sure that every time the screen appears the values are updated with the received paramters
        .onAppear {
            cases.getHistory(country: country.iso) { (returned_cases, returned_deaths) in
                self.casesArr.append(contentsOf: returned_cases)
                self.deathsArr.append(contentsOf: returned_deaths)
            }
            cases.getVaccines(country: country.iso) { (returned_vaccines) in
                self.vaccinesArr.append(contentsOf: returned_vaccines)
            }
        }
    }
}

struct GraphsView_Previews: PreviewProvider {
    static var previews: some View {
        GraphsView(country: Cases.dummy, cases: DataModel())
    }
}
