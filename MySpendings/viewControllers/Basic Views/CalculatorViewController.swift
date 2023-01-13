//
//  CalculatorViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit
import SwiftUI

class CalculatorViewController: UIViewController {

    var mainView: MainViewController?
    
    @IBOutlet weak var view_MainBody: UIView!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = tabBarController as? MainViewController
        
        
        // Do any additional setup after loading the view.
        pageLook()
        
        updateTheme()
    }
    
    
    
    func pageLook() // to have the fancy look of the application
    {
        view_MainBody.layer.cornerRadius = 45
        view_MainBody.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        view_MainBody.layer.shadowColor = UIColor.black.cgColor
        view_MainBody.layer.shadowOpacity = 0.18
        view_MainBody.layer.shadowRadius = 10
        view_MainBody.layer.shadowOffset = CGSize(width: 0, height: -10)
        
        updateTheme()
    }
    
    func updateTheme()
    {
        view_MainBody.backgroundColor = mainView!.mianColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTheme()
    }

}
