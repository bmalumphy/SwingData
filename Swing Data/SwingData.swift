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
    
    /*Helper function for incrementing over the arrays of a player's SwingData.
     *
     *The algroithm is exactly the same as before, and runs in O(n) time with O(n) space
     *
     *However, in order to avoid decreasing readability of the code, it needs to be implemented in two
     *ways using polymorphism. The first case uses one data array, while the second utilizes two. This is
     *necessary because if it were somehow wrapped into one function, there would have to be some very messy
     *cleanup for each case. If wrapped into a [[Double]] of length 2, we would have to check if one of the
     *data arrays is empty. Or if wrapped into two inputs data1 and data2 by default, data2 would have to be
     *empty for the single array case.
     *
     *Being that this function always takes in thresholdLo and thresholdHi arguments, the functions that
     *require only one argument for threshold may choose to input a velocity or acceleration for the upper
     *bound that would be unreasonable for a player to achieve.
     *
     */
    func counting(data: [Double], winLength: Int, indexBegin: Int, indexEnd: Int, thresholdLo: Double, thresholdHi: Double) -> Int {
        //catch for improper indexing
        if(indexEnd >= data.count){
            return -1
        }
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
            }
        }
        return -1
    }
    
    func counting(data1: [Double], data2: [Double], winLength: Int, indexBegin: Int, indexEnd: Int, threshold1: Double, threshold2: Double) -> Int {
        var count = 0
        var beginningIndex = -1
        for t in indexBegin...indexEnd {
            if data1[t] >= threshold1 && data2[t] >= threshold2 {
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
    
    //Checkes for acceleration or velocity values above a certain threshold within a timeframe winLength
    //returns -1 when no such acceleration or velocity is found
    //Time complexity O(n) where n is the length of data[]
    public func searchContinuityAboveValue(data: [Double], indexBegin: Int, indexEnd: Int, threshold: Double, winLength: Int) -> Int{
        
        return counting(data: data, winLength: winLength, indexBegin: indexBegin, indexEnd: indexEnd, thresholdLo: threshold, thresholdHi: 1000)
        
    }
    
    //Checkes for acceleration or velocity values within a certain threshold range within a timeframe winLength
    //returns -1 when no such acceleration or velocity is found
    //Time complexity O(n) where n is the length of data[]
    public func backSearchContinuityWithinRange(data: [Double], indexBegin: Int, indexEnd: Int, thresholdLo: Double, thresholdHi: Double, winLength: Int) -> Int{
        return counting(data: data, winLength: winLength, indexBegin: indexBegin, indexEnd: indexEnd, thresholdLo: thresholdLo, thresholdHi: thresholdHi)

    }
    
    //Checkes for acceleration or velocity values above a certain threshold within a timeframe winLength
    //across 2 arrays of data
    //returns -1 when no such acceleration or velocity is found
    //Time complexity O(n) where n is the length of data[]
    public func searchContinuityAboveValueTwoSignals(data1: [Double], data2: [Double], indexBegin: Int, indexEnd: Int, threshold1: Double, threshold2: Double, winLength: Int) -> Int{

        return counting(data1: data1, data2: data2, winLength: winLength, indexBegin: indexBegin, indexEnd: indexEnd, threshold1: threshold1, threshold2: threshold2)
    }
    
    //Checkes for acceleration or velocity values above a certain threshold within a timeframe winLength
    //returns the range on which the values are achieved.
    //returns -1 when no such acceleration or velocity is found
    //Time complexity O(n) where n is the length of data[]
    public func searchMultiContinuityWithinRange(data: [Double], indexBegin: Int, indexEnd: Int, thresholdLo: Double, thresholdHi: Double, winLength: Int) -> [Int]{
        
        let beginningIndex = counting(data: data, winLength: winLength, indexBegin: indexBegin, indexEnd: indexEnd, thresholdLo: thresholdLo, thresholdHi: thresholdHi)
        if beginningIndex == -1 {
            return []
        }
        return [beginningIndex, beginningIndex + winLength - 1]
    }
    
}
