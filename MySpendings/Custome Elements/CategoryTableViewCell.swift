//
//  CategoryTableViewCell.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var view_CellBody: UIView!
    
    @IBOutlet weak var img_CatIcon: UILabel!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Items: UILabel!
    @IBOutlet weak var lbl_Total: UILabel!
    
    @IBOutlet weak var btn_Info: UIButton!
    @IBOutlet weak var btn_Edit: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
