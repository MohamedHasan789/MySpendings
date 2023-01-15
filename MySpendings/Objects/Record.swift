//
//  Record.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import Foundation
import UIKit


// record object, treated as a "database" for all of the application, - was going to use a database connection but time constraints didnt allow
struct Record: Codable
{
    // the list of records (months of year), and their categories
    var records: [String: [Category]] = [:]

    // the list of "map keys" for the records (month, year)
    var rcrdsList: [String] = []
    
    // the list of fav catgs for each record
    var favs: [Int: [Int]] = [:]
    
    // the list of permanint categories (categories that will be added by defult each record (month))
    var prmntCatgrs: [Category] = []
    
    // basic variabels for data storage
    var currRcrd: String = ""
    var currIndex: Int = 0
    
    // to check whether there is prev or next records (used for home arrows)
    var hasNext = false
    var hasBefore = false
    var catgChanged = false
    
    // to recall the currancy sellection
    var currncy = "BHD د.ب"
    var currncyIndex = 0

    // method to get the total record (month) spenidngs
    func getTotal() -> Double
    {
        var sum = 0.0
        
        if let categories = records[currRcrd]
        {
            for catg in categories
            {
                sum += catg.getTotal()
            }
        }
        
        return sum
    }
    
    
    // data saving and retrevel methods and statics
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
    
    // sample data entries
    static func loadSampleData() -> Record {
        let item1 = Item(icon: "🫒", name: "olives", isDeduct: true, price: 0.4, amount: 4, dateTime: Date())
        let item2 = Item(icon: "🍔", name: "micides", isDeduct: true, price: 2.4, amount: 1, dateTime: Date(), rcptImage: UIImage(named: "raseed")?.jpegData(compressionQuality: 0.9))
        let item3 = Item(icon: "💸", name: "cupon", isDeduct: false, price: 0.5, amount: 2, dateTime: Date())
        
        let item4 = Item(icon: "🚰", name: "Water", isDeduct: true, price: 5, amount: 1, dateTime: Date())
        let item5 = Item(icon: "🔌", name: "electricity", isDeduct: true, price: 15, amount: 1, dateTime: Date())
        
        let catg1 = Category(icon: "🏠", name: "house", permanentategory: true, alowOverBudgt: false, items: [item4,item5])
        let catg2 = Category(icon: "🍱", name: "food", permanentategory: false, alowOverBudgt: false, items: [item1,item2,item3])
        
        let currRcrd = "February, 2020"
        
        
        let record = Record(records: ["February, 2020" : [catg1,catg2]], rcrdsList: [currRcrd], favs: [0:[0]], prmntCatgrs: [catg1], currRcrd: "February, 2020", currIndex: 0, hasNext: false, hasBefore: false, catgChanged: false, currncy: "BHD د.ب", currncyIndex: 0)
        
        return record
    }
}
