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
    var image = UIImage()
    var name: String
    var description: String
    
    var budget: Int
    
    
    var resetCaregory: Bool
    var permanentCategory: Bool
    var alowOverBudgt: Bool
    
    var items: [Item]
}
