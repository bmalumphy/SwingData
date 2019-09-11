//
//  PopupViewController.swift
//  Swing Data
//
//  Created by Bryan Malumphy on 9/10/19.
//  Copyright © 2019 Math and Coffee. All rights reserved.
//

import UIKit
import Charts

class PopupViewController: UIViewController {

    @IBOutlet weak var impactLabel: UILabel!
    @IBOutlet weak var accelerationChartView: LineChartView!
    @IBOutlet weak var velocityChartView: LineChartView!
    var accelerationX: [Double] = []
    var velocityX: [Double] = []
    
    var lineChartEntry1 = [ChartDataEntry]()
    var lineChartEntry2 = [ChartDataEntry]()
    
    var impactTime: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Controller parameters:")
        print(self.accelerationX)
        print(self.velocityX)
        print(self.impactTime)
        updateGraph()
        
    }
    
    
    
    func updateGraph(){
        
        //here is the for loop
        for i in 0..<accelerationX.count {
            
            let value = ChartDataEntry(x: Double(i), y: accelerationX[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry1.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "Acceleration along X") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        
        let data1 = LineChartData() //This is the object that will be added to the chart
        data1.addDataSet(line1) //Adds the line to the dataSet
        
        
        accelerationChartView.data = data1 //finally - it adds the chart data to the chart and causes an update
        accelerationChartView.chartDescription?.text = "Net Acceleration of Bat" // Here we set the description for the graph
        for j in 0..<velocityX.count {
            
            let value = ChartDataEntry(x: Double(j), y: velocityX[j]) // here we set the X and Y status in a data chart entry
            lineChartEntry2.append(value) // here we add it to the data set
        }
        let line2 = LineChartDataSet(entries: lineChartEntry2, label: "Velocity along X") //Here we convert lineChartEntry to a LineChartDataSet
        line2.colors = [NSUIColor.blue] //Sets the colour to blue
        
        let data2 = LineChartData() //This is the object that will be added to the chart
        data2.addDataSet(line2) //Adds the line to the dataSet
        
        
        velocityChartView.data = data2 //finally - it adds the chart data to the chart and causes an update
        velocityChartView.chartDescription?.text = "Net Velocity of Bat" // Here we set the description for the graph
        self.impactLabel.text = "~"+String(self.impactTime)
    }
    
}
