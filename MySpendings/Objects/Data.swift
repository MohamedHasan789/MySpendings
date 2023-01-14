//
//  Data.swift
//  MySpendings
//
//  Created by Mohamed on 14/01/2023.
//

import Foundation

struct Data
{
    var records: [String: [Category]] = [:]

    var rcrdsList: [String] = []
    
    
    var currRcrd: String = ""
    var currIndex: Int = 0
    
    var prmntCatgrs: [Category] = []

    
    var hasNext = false
    var hasBefore = false
    var catgChanged = false
    
    var currncy = "BHD د.ب"
    var curIndex = 0
}


