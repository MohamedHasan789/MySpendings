//
//  ItemTableViewCell.swift
//  MySpendings
//
//  Created by Mohamed on 10/01/2023.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img_ItemIcon: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
