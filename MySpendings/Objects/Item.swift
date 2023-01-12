//
//  Item.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import Foundation
import UIKit

class Item: Equatable
{
    let id = UUID()
    var icon: String
    var name: String
    var isDeduct: Bool
    var price: Double
    var amount: Int
    var dateTime: Date
    
    init(icon: String, name: String, isDeduct: Bool, price: Double, amount: Int, dateTime: Date)
    {
        self.icon = icon
        self.name = name
        self.isDeduct = isDeduct
        self.price = price
        self.amount = amount
        self.dateTime = dateTime
    }
    
    //reciept part
    
    func getPrice() -> Double
    {
        return Double(self.amount)*self.price
    }
    
    
    // might not need
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
}

func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.id == rhs.id
}
