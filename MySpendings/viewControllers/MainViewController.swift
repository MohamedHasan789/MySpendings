//
//  MainViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class MainViewController: UITabBarController{
    
    // **PLEASE NOTE** //
    // as that "mainView" is the tabbar controller and will always be present no matter which view the user is in, it will be force unrapwd for the entirity if the application, this is done to nigate the extra "14251" lines of code requiried for each entry of the "mainView!"
    // **PLEASE NOTE** //
    
    // here is the file where most logic happens (calculations and stuffs), creating records, and the connection to the database
    var record = Record()
    
    // user color selection, placed here to make them global to the application, none codable
    var mianColor = UIColor(red: 0.891, green: 0.999, blue: 0.856, alpha: 1.0)
    var scndColor = UIColor(red: 0.787, green: 0.998, blue: 0.718, alpha: 1.0)
    var itemsColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if there is a saved record file, use it
        if let savedRecord = Record.loadRecord()
        {
            record = savedRecord
        }
        else
        {
            record = Record.loadSampleData() // examble data rather than new data
        }
        
        /*
        // start a new record if its the app's first time to be opened
        if record.rcrdsList.isEmpty
        {
            newRecord()
        }
        */
        
        
        
        
        checkCurRcrd()
        
        setLatstRcrd()
        
        checkList()
    }
    
    
    // a function to see if the latest record is the crnt month or not, if so, create a new record
    func checkCurRcrd()
    {
        if (record.rcrdsList.last != getCurrRecordName())
        {
            newRecord()
        }
    }
    
    
    // to open the application on the crnt record
    func setLatstRcrd()
    {
        record.currRcrd = getCurrRecordName()
        record.currIndex = record.rcrdsList.endIndex - 1
    }
    
    // a function to format and create a record name (this month, this year)
    func getCurrRecordName() -> String
    {
        let year = Calendar.current.component(.year, from: Date())
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: date)
        // implemented from https://www.zerotoappstore.com/get-year-month-day-from-date-swift.html (only the month formater)
        
        return "\(month), \(year)"
    }
    
    // create a new record and initilize its req parameters
    func newRecord()
    {
        record.records[getCurrRecordName()] = []
        record.rcrdsList.append(getCurrRecordName())
        record.currRcrd = getCurrRecordName()
        record.currIndex = record.rcrdsList.endIndex - 1
        
        if record.prmntCatgrs.count <= 1
        {
            for catgory in record.prmntCatgrs
            {
                record.records[record.currRcrd]?.append(catgory)
            }
        }
        
        record.favs[record.currIndex] = []
        
        checkList()
    }
    
    // make the curr record the prev avaible one
    func goBack()
    {
        if record.currIndex > 0
        {
            record.currRcrd = record.rcrdsList[record.currIndex-1]
            record.currIndex -= 1
            
            record.catgChanged = true
        }
        
        checkList()
    }
    
    // make the curr record the next avaible one
    func goForward()
    {
        if record.currIndex < (record.rcrdsList.count - 1)
        {
            record.currRcrd = record.rcrdsList[record.currIndex+1]
            record.currIndex += 1
            
            record.catgChanged = true
        }
        
        checkList()
    }
    
    // check if there is next items in the list (forwardm backward)
    func checkList()
    {
        if (record.rcrdsList.count == 1)
        {
            record.hasNext = false
            record.hasBefore = false
        }
        else
        {
            if (record.currIndex == 0)
            {
                record.hasNext = true
                record.hasBefore = false
            }
            else if (record.currIndex > 0 && record.currIndex < (record.rcrdsList.count - 1))
            {
                record.hasNext = true
                record.hasBefore = true
            }
            else if (record.currIndex == (record.rcrdsList.count - 1))
            {
                record.hasNext = false
                record.hasBefore = true
            }
        }
    }
    
    
    //save information on closre - not really functional
    override func viewWillDisappear(_ animated: Bool) {
        Record.saveRocrd(record)
    }
}
