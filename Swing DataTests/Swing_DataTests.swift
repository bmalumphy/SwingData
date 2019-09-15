//
//  Swing_DataTests.swift
//  Swing DataTests
//
//  Created by Bryan Malumphy on 9/9/19.
//  Copyright © 2019 Math and Coffee. All rights reserved.
//

import XCTest
@testable import Swing_Data

class Swing_DataTests: XCTestCase {

    private var battingData: [[Double]]!
    override func setUp() {
        
        if let csvData = readDataFromCSV(fileName: "latestSwing", fileType: "csv"){
            let csv_sring = csv(data: csvData)
            if let battingData = convertDataToDouble(data: csv_sring){
                self.battingData = battingData
            }else{
                assert(false)
            }
        }else{
            assert(false)
        }
    }

    override func tearDown() {
        
        
    }

//    func testCSV() {
//        if let csvData = readDataFromCSV(fileName: "latestSwing", fileType: "csv"){
//            let csv_sring = csv(data: csvData)
//            if let battingData = convertDataToDouble(data: csv_sring){
//                XCTAssertEqual(-1.038086, battingData[3][7])
//            }else{
//                assert(false)
//            }
//        }else{
//            assert(false)
//        }
//    }
    
    func testSwingData() {
        let swingData: SwingData = SwingData(data: self.battingData)
        
        let wx = swingData.wx
        let wy = swingData.wy
        
        //searchContiunuityAboveValue tests
        XCTAssertEqual(0, swingData.searchContinuityAboveValue(data: wx, indexBegin: 0, indexEnd: wx.count-1, threshold: 1, winLength: 5), "base check for value that's always true")
        XCTAssertEqual(-1, swingData.searchContinuityAboveValue(data: wx, indexBegin: 0, indexEnd: wx.count-1, threshold: 1, winLength: wx.count+1), "Should always be -1 because of winLength being too high")
        XCTAssertEqual(854, swingData.searchContinuityAboveValue(data: wy, indexBegin: 0, indexEnd: wy.count-1, threshold: 34, winLength: 10))
        
        //backSearchContinuityWithinRange tests
        XCTAssertEqual(116, swingData.backSearchContinuityWithinRange(data: wx, indexBegin: 0, indexEnd: wx.count-1, thresholdLo: 0, thresholdHi: 1, winLength: 5), "base check for value that's always true")
        XCTAssertEqual(-1, swingData.backSearchContinuityWithinRange(data: wx, indexBegin: 0, indexEnd: wx.count-1, thresholdLo: -100, thresholdHi: 100, winLength: wx.count+1), "Should always be -1 because of winLength being too high")
        XCTAssertEqual(845, swingData.backSearchContinuityWithinRange(data: wy, indexBegin: 0, indexEnd: wy.count-1, thresholdLo: 29, thresholdHi: 150, winLength: 20))
        
        //searchContinuityAboveValueTwoSignals tests
        XCTAssertEqual(891, swingData.searchContinuityAboveValueTwoSignals(data1: wx, data2: wy, indexBegin: 0, indexEnd: wx.count-1, threshold1: 10, threshold2: 20, winLength: 5))
        
        //searchMultipContinuityWithinRange tests
        XCTAssertEqual([845, 864], swingData.searchMultiContinuityWithinRange(data: wy, indexBegin: 0, indexEnd: wx.count-1, thresholdLo: 29, thresholdHi: 150, winLength: 20))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
