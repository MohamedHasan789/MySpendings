//
//  HelpTableViewCell.swift
//  MySpendings
//
//  Created by Mohamed on 13/01/2023.
//

import UIKit

class HelpTableViewCell: UITableViewCell {

    @IBOutlet weak var img_Icon: UIImageView!
    @IBOutlet weak var img_Chevron: UIImageView!
    
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Body: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img_Icon.image = UIImage(systemName: "info.circle")
        img_Chevron.image = UIImage(systemName: "chevron.forward")
        
    }



}
