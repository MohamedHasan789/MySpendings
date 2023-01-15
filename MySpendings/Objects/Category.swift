//
//  Category.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import Foundation
import UIKit


// the main category type, has an opt description and cmprsn methods (for name)
struct Category: Codable {
    var id = UUID()
    var icon:String
    var name: String
    var description: String?
    
    var budget: Double?
    
    var permanentategory: Bool
    var alowOverBudgt: Bool
    
    // the list of items for this category
    var items: [Item]
    
    // function to get the total price of all items in the category
    func getTotal() -> Double
    {
        var sum: Double = 0.0
        for item in items {
            sum += item.getPrice()
        }
        return sum
    }
    
    // compar functions (sorting, searching)
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


