//
//  ItemsViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class ItemsViewController: UIViewController {
    
    var catgoryName: String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = catgoryName
    }
    
    
    init?(coder: NSCoder, catgoryName: String)
    {
        self.catgoryName = catgoryName
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
