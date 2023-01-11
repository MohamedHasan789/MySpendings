//
//  Category.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import Foundation
import UIKit

struct Category {
    let id = UUID()
    var icon:String
    var name: String
    var description: String?
    
    var budget: Double?
    var resetEvery: Int?
    
    var permanentCategory: Bool
    var alowOverBudgt: Bool
    
    var items: [Item]
    
    func getTotal() -> Double
    {
        var sum: Double = 0.0
        for item in items {
            sum += item.price
        }
        return sum
    }
}
