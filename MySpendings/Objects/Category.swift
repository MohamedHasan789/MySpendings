//
//  Category.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import Foundation
import UIKit

struct Category: Codable {
    var id = UUID()
    var icon:String
    var name: String
    var description: String?
    
    var budget: Double?
    
    var permanentategory: Bool
    var alowOverBudgt: Bool
    
    var items: [Item]
    
    func getTotal() -> Double
    {
        var sum: Double = 0.0
        for item in items {
            sum += item.getPrice()
        }
        return sum
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Category, rhs: Category) -> Bool
    {
        return lhs.name < rhs.name
    }
    
    static func > (lhs: Category, rhs: Category) -> Bool
    {
        return lhs.name > rhs.name
    }
}


