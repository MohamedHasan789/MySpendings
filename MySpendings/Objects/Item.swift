//
//  Item.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import Foundation
import UIKit

// item within category, has an image for the reciept that will be saved as data (for data saving nd getting)
struct Item: Equatable, Comparable, Codable
{
    var id = UUID()
    var icon: String
    var name: String
    var isDeduct: Bool
    var price: Double
    var amount: Int
    var dateTime: Date
    var rcptImage: Data?
    

    
    func getPrice() -> Double
    {
        var price = Double(self.amount)*self.price
        if (!isDeduct)
        {
            price =  Double(self.amount)*self.price * -1
        }
        return price
    }
    
    
    static func ==(lhs: Item, rhs: Item) -> Bool
    {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Item, rhs: Item) -> Bool
    {
        return lhs.name < rhs.name
    }
    
    static func > (lhs: Item, rhs: Item) -> Bool
    {
        return lhs.name > rhs.name
    }
}


