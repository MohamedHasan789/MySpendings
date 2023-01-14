//
//  Record.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import Foundation


struct Record: Codable
{
    var records: [String: [Category]] = [:]

    var rcrdsList: [String] = []
    
    var favs: [Int: [Int]] = [:]
    
    var prmntCatgrs: [Category] = []
    
    var currRcrd: String = ""
    var currIndex: Int = 0
    
    var hasNext = false
    var hasBefore = false
    var catgChanged = false
    
    var currncy = "BHD د.ب"
    var curIndex = 0

    
    func getTotal() -> Double
    {
        var sum = 0.0
        
        for catg in records[currRcrd]!
        {
            sum += catg.getTotal()
        }
        
        return sum
    }
    
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("mySpendingRcrd").appendingPathExtension("plist")
    
    static func saveRocrd(_ record: Record) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(record)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadRecord() -> Record?  {
        guard let codedRecord = try? Data(contentsOf: archiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Record.self, from: codedRecord)
    }
    

}
