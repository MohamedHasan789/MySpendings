//
//  MainViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class MainViewController: UITabBarController{
    
    // here is the file where most logic happens (calculations and stuffs)
    var record = Record()
    
    var mianColor = UIColor(red: 0.891, green: 0.999, blue: 0.856, alpha: 1.0)
    var scndColor = UIColor(red: 0.787, green: 0.998, blue: 0.718, alpha: 1.0)
    var itemsColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedRecord = Record.loadRecord()
        {
            record = savedRecord
        }
        
        
        // start a new record if its the first time to be opened
        if record.rcrdsList.isEmpty
        {
            newRecord()
        }
        
        
        checkCurRcrd()
        
        setLatstRcrd()
        
        
        // please note that the "reset catgory" was not implemented yet, for now that feture is not implemnted
        checkList()
        
    }
    
    
    // a function to see if the latest record availbe is not the currnt month
    func checkCurRcrd()
    {
        if (record.rcrdsList.last != getCurrRecordName())
        {
            newRecord()
        }
    }
    
    
    // sets the currant open record to be of the crnt month
    func setLatstRcrd()
    {
        record.currRcrd = getCurrRecordName()
        record.currIndex = record.rcrdsList.endIndex - 1
    }
    
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
    
    func newRecord()
    {
        record.records[getCurrRecordName()] = []
        record.rcrdsList.append(getCurrRecordName())
        record.currRcrd = getCurrRecordName()
        record.currIndex = record.rcrdsList.endIndex - 1
        
        record.favs[record.curIndex] = []
        
        checkList()
    }
    
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
}
