//
//  MainViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    // here is the file where most logic happens (calculations and stuffs)
    
    var viewDemo: Bool = true
    
    var usrRcord: [Record] = []
    var currRcrd: Int = 0
    
    // categories that will be present every month
    var usrRptCatgrs: [Category] = []
    
    
    // color stuff, get the colors from here as well
    //var baseColor: UIColor() = UIColor(
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
