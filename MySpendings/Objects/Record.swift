//
//  Record.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import Foundation

struct Record
{
    var month: Date
    var categories: [Category]
    
    func getTotal() -> Double
    {
        var total: Double = 0
        
        for category in categories
        {
            for item in category.items
            {
                total += item.getPrice()
            }
        }
        
        return total
    }
}
