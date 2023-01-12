//
//  MainViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    // here is the file where most logic happens (calculations and stuffs)
    
    var viewDemo: Bool = true
    
    var records: [String: [Category]] = [:]

    var rcrdsList: [String] = []
    
    
    var currRcrd: String = ""
    var currIndex: Int = 0
    
    var prmntCatgrs: [Category] = []

    
    var hasNext = false
    var hasBefore = false
    var catgChanged = false
    
    // color stuff, get the colors from here as well
    //var baseColor: UIColor() = UIColor(
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if rcrdsList.isEmpty
        {
            newRecord()
            
            print(getCurrRecordName())
            print(rcrdsList)
            print(currIndex)
            print(currRcrd)
        }
        
        
        //some extra additions for testing
        records["Febray, 2023"] = []
        rcrdsList.append("Febray, 2023")
        
        records["March, 2023"] = []
        rcrdsList.append("March, 2023")
        
        records["Apr, 2023"] = []
        rcrdsList.append("Apr, 2023")
        //currRcrd = getCurrRecordName()
        //currIndex = rcrdsList.endIndex - 1
        
        checkList()
        
        
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
