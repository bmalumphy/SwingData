//
//  ViewController.swift
//  Swing Data
//
//  Created by Bryan Malumphy on 9/9/19.
//  Copyright © 2019 Math and Coffee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let backgroundImageView = UIImageView()
    var startingIndex: Int = 0
    var endingIndex: Int = 0
    var battingData: [[Double]] = []
    var acceleration: [Double] = []
    var velocity: [Double] = []
    var impactTime: Int = 0
    @IBOutlet weak var swing_btn: StyledButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setData()
    }

    func setData() {
        if let csvData = readDataFromCSV(fileName: "latestSwing", fileType: "csv"){
            let csv_sring = csv(data: csvData)
            if let battingData = convertDataToDouble(data: csv_sring){
                self.battingData = battingData
            }else{
                self.battingData = []
            }
        }else{
            self.battingData = []
        }
        let swingData: SwingData = SwingData(data: self.battingData)
        
        self.acceleration = swingData.ax
        self.velocity = swingData.wx
        self.impactTime = swingData.searchContinuityAboveValue(data: swingData.ax, indexBegin: 0, indexEnd: swingData.ax.count-1, threshold: 5, winLength: 5)
        print("ax and wx")
        print(self.acceleration)
        print(self.velocity)
    }
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "baseballBackground")
        
        view.sendSubviewToBack(backgroundImageView)
    }
    
   
    
    @IBAction func swing(_ sender: Any) {
        
    }
    
    func magnitude(x: Double, y: Double, z: Double) -> Double{
        return (x*x+y*y+z*z).squareRoot()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? PopupViewController
        {
            vc.accelerationX = self.acceleration
            vc.velocityX = self.velocity
            vc.impactTime = self.impactTime
        }
    }
}

