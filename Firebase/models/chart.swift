//
//  chart.swift
//  Firebase
//
//  Created by Daniel on 18/12/21.
//

import Foundation


// MARK: - RootChart
class RootChart: Codable {
    var colors: [String]?
    var questions: [Question]?

    init(colors: [String]?, questions: [Question]?) {
        self.colors = colors
        self.questions = questions
    }
}

// MARK: - Question
class Question: Codable {
    var total: Int?
    var text: String?
    var chartData: [ChartDatum]?

    init(total: Int?, text: String?, chartData: [ChartDatum]?) {
        self.total = total
        self.text = text
        self.chartData = chartData
    }
}

// MARK: - ChartDatum
class ChartDatum: Codable {
    var text: String?
    var percetnage: Int?

    init(text: String?, percetnage: Int?) {
        self.text = text
        self.percetnage = percetnage
    }
}
