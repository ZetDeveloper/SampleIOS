//
//  GRaphTableViewCell.swift
//  Firebase
//
//  Created by Daniel on 18/12/21.
//

import UIKit
import Charts



class GRaphTableViewCell: UITableViewCell {

    @IBOutlet weak var chart: PieChartView!
    var rowModel: RowModel?
    @IBOutlet weak var questionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setRowModel(rowModel: RowModel){
        self.rowModel = rowModel
        questionLabel.text = rowModel.question?.text
        updateChartData()
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func updateChartData()  {
        var entries = [PieChartDataEntry]()
        for (_, value) in  self.rowModel!.question!.chartData!.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = Double(value.percetnage!)
            entry.label = value.text
            entries.append( entry)
        }
        
        let set = PieChartDataSet( entries: entries, label: self.rowModel?.question?.text ?? "")
        var colors: [UIColor] = []
        
        for (_, value) in self.rowModel!.colors!.enumerated() {
            debugPrint(value)
            let color = hexStringToUIColor(hex: value)
            colors.append(color)
        }
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        // user interaction
        chart.isUserInteractionEnabled = true
        
        //let d = Description()
        //d.text = self.rowModel?.question?.text ?? ""
        //chart.chartDescription = d
        //chart.centerText = self.rowModel?.question?.text ?? ""
        chart.holeRadiusPercent = 0.8
        chart.transparentCircleColor = UIColor.clear
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
