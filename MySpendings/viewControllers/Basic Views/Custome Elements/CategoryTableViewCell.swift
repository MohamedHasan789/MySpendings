//
//  CategoryTableViewCell.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img_CatIcon: UILabel!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Items: UILabel!
    @IBOutlet weak var lbl_Total: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
