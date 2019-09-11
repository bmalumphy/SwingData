//
//  CSV_Manipulation.swift
//  Swing Data
//
//  Created by Bryan Malumphy on 9/9/19.
//  Copyright © 2019 Math and Coffee. All rights reserved.
//

import Foundation

public func readDataFromCSV(fileName:String, fileType: String)-> String!{
    guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
        else {
            return nil
    }
    do {
        var contents = try String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        return contents
    } catch {
        print("File Read Error for file \(filepath)")
        return nil
    }
}


public func cleanRows(file:String)->String{
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
}


public func csv(data: String) -> [[String]] {
    var result: [[String]] = []
    let rows = data.components(separatedBy: "\n")
    for row in rows {
        let columns = row.components(separatedBy: ",")
        result.append(columns)
    }
    return result
}

public func convertDataToDouble(data: [[String]]) -> [[Double]]!{
    var doubleData: [[Double]] = []
    for i in 0...data[0].count-1{
        var dataColumn: [Double] = []
        for j in 0...data.count-1{
            if let entry = Double(data[j][i]){
                dataColumn.append(entry)
            }else{
                print("Data was improperly written")
                return nil
            }
            
        }
        doubleData.append(dataColumn)
    }
    return doubleData
}
