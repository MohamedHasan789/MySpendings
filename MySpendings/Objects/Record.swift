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


}
