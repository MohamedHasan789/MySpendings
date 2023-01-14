//
//  MainViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class MainViewController: UITabBarController{
    
    // here is the file where most logic happens (calculations and stuffs)
    
    
    var records: [String: [Category]] = [:]

    var rcrdsList: [String] = []
    
    
    var currRcrd: String = ""
    var currIndex: Int = 0
    
    var favs: [Int: [Int]] = [:]
    
    var prmntCatgrs: [Category] = []

    
    var hasNext = false
    var hasBefore = false
    var catgChanged = false
    
    
    var mianColor = UIColor(red: 0.891, green: 0.999, blue: 0.856, alpha: 1.0)
    var scndColor = UIColor(red: 0.787, green: 0.998, blue: 0.718, alpha: 1.0)
    var itemsColor = UIColor.white
    
    var currncy = "BHD د.ب"
    var curIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // start a new record if its the first time to be opened
        if rcrdsList.isEmpty
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
        if (rcrdsList.last != getCurrRecordName())
        {
            newRecord()
        }
    }
    
    
    // sets the currant open record to be of the crnt month
    func setLatstRcrd()
    {
        currRcrd = getCurrRecordName()
        currIndex = rcrdsList.endIndex - 1
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
        records[getCurrRecordName()] = []
        rcrdsList.append(getCurrRecordName())
        currRcrd = getCurrRecordName()
        currIndex = rcrdsList.endIndex - 1
        
        favs[curIndex] = []
        
        checkList()
    }
    
    func goBack()
    {
        if currIndex > 0
        {
            currRcrd = rcrdsList[currIndex-1]
            currIndex -= 1
            
            catgChanged = true
        }
        
        checkList()
    }
    
    func goForward()
    {
        if currIndex < (rcrdsList.count - 1)
        {
            currRcrd = rcrdsList[currIndex+1]
            currIndex += 1
            
            catgChanged = true
        }
        
        checkList()
    }
    
    func checkList()
    {
        if (rcrdsList.count == 1)
        {
            hasNext = false
            hasBefore = false
        }
        else
        {
            if (currIndex == 0)
            {
                hasNext = true
                hasBefore = false
            }
            else if (currIndex > 0 && currIndex < (rcrdsList.count - 1))
            {
                hasNext = true
                hasBefore = true
            }
            else if (currIndex == (rcrdsList.count - 1))
            {
                hasNext = false
                hasBefore = true
            }
        }
    }
}
