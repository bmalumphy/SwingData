//
//  SwingData.swift
//  Swing Data
//
//  Created by Bryan Malumphy on 9/9/19.
//  Copyright © 2019 Math and Coffee. All rights reserved.
//

import Foundation

class SwingData {
    
    var ax: [Double]
    var ay: [Double]
    var az: [Double]
    var wx: [Double]
    var wy: [Double]
    var wz: [Double]
    var timeStamps: [Double]
    
    init(timeStamps: [Double], ax: [Double], ay: [Double], az: [Double], wx: [Double], wy: [Double], wz: [Double]){
        self.timeStamps = timeStamps
        self.ax = ax
        self.ay = ay
        self.az = az
        self.wx = wx
        self.wy = wy
        self.wz = wz
    }
    
    init(data: [[Double]]){
        //Must be properly formated from CSV
        self.timeStamps = data[0]
        self.ax = data[1]
        self.ay = data[2]
        self.az = data[3]
        self.wx = data[4]
        self.wy = data[5]
        self.wz = data[6]
    }
    
    //Checkes for acceleration or velocity values above a certain threshold within a timeframe winLength
    //returns -1 when no such acceleration or velocity is found
    //Time complexity O(n) where n is the length of data[]
    public func searchContinuityAboveValue(data: [Double], indexBegin: Int, indexEnd: Int, threshold: Double, winLength: Int) -> Int{
        var count = 0
        var beginningIndex = -1
        for t in indexBegin...indexEnd {
            if data[t] >= threshold {
                if count == 0 {
                    beginningIndex = t
                }
                count += 1
                if count == winLength {
                    return beginningIndex
                }
            }else{
                count = 0
                beginningIndex = -1
            }
        }
        
        return -1
    }
    
    //Checkes for acceleration or velocity values within a certain threshold range within a timeframe winLength
    //returns -1 when no such acceleration or velocity is found
    //Time complexity O(n) where n is the length of data[]
    public func backSearchContinuityWithinRange(data: [Double], indexBegin: Int, indexEnd: Int, thresholdLo: Double, thresholdHi: Double, winLength: Int) -> Int{
        var count = 0
        var beginningIndex = -1
        for t in indexBegin...indexEnd {
            if data[t] <= thresholdHi && data[t] >= thresholdLo{
                if count == 0 {
                    beginningIndex = t
                }
                count += 1
                if count == winLength {
                    return beginningIndex
                }
            }else{
                count = 0
                beginningIndex = -1
            }
        }
        return -1
    }
    
    //
    public func searchContinuityAboveValueTwoSignals(data1: [Double], data2: [Double], indexBegin: Int, indexEnd: Int, threshold1: Double, threshhold2: Double, winLength: Int) -> Int{
        var count = 0
        var beginningIndex = -1
        for t in indexBegin...indexEnd {
            if data1[t] >= threshold1 && data2[t] >= threshhold2 {
                if count == 0 {
                    beginningIndex = t
                }
                count += 1
                if count == winLength {
                    return beginningIndex
                }
            }else{
                count = 0
                beginningIndex = -1
            }
        }
        return -1
    }
    
    //
    public func searchMultiContinuityWithinRange(data: [Double], indexBegin: Int, indexEnd: Int, thresholdLo: Double, thresholdHi: Double, winLength: Int) -> [Int]{
        var count = -1
        var range = [Int]()
        var beginningIndex = 0
        for t in indexBegin...indexEnd {
            if data[t] <= thresholdHi && data[t] >= thresholdLo{
                if count == 0 {
                    beginningIndex = t
                }
                count += 1
                if count == winLength {
                    range.append(beginningIndex)
                    range.append(t)
                    return range
                }
            }else{
                count = 0
                beginningIndex = -1
                range = [Int]()
            }
        }
        return []
    }
    
}
