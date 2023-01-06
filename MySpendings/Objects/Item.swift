//
//  Item.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import Foundation
import UIKit

struct Item {
    let id = UUID()
    var image = UIImage()
    var name: String
    var price: Double
    var amount: Int
    var dateTime: Date
    
    //reciept part
    
    func getPrice() -> Double
    {
        return Double(self.amount)*self.price
    }
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    
}
