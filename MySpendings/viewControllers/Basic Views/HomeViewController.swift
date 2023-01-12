//
//  HomeViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var view_HomeTop: UIView!
    @IBOutlet weak var view_HomeBody: UIView!
    
    
    @IBOutlet weak var lbl_RcrdTotal: UILabel!
    
    @IBOutlet weak var btn_NextRcrd: UIButton!
    @IBOutlet weak var btn_PrevRcrd: UIButton!
    
    
    var mainView: MainViewController? = nil
    var rcrdKeys: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // call the "fancy" looks function
        pageLook()
        
        refreshPage()
        
    }
    
    
    @IBAction func btn_NextRcrd(_ sender: Any)
    {
        mainView!.goForward()
        refreshPage()
    }
    
    @IBAction func btn_PrevRcrd(_ sender: Any)
    {
        mainView!.goBack()
        refreshPage()
    }
    
    
    
    func pageLook() // to have the fancy look of the application
    {
        view_HomeTop.layer.cornerRadius = 45
        view_HomeTop.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        view_HomeBody.layer.shadowColor = UIColor.black.cgColor
        view_HomeBody.layer.shadowOpacity = 0.3
        view_HomeBody.layer.shadowRadius = 5
        
        view_HomeTop.layer.shadowColor = UIColor.black.cgColor
        view_HomeTop.layer.shadowOpacity = 0.18
        view_HomeTop.layer.shadowRadius = 10
        view_HomeTop.layer.shadowOffset = CGSize(width: 0, height: -10)
        
        view_HomeBody.layer.shouldRasterize = true
        view_HomeBody.layer.shouldRasterize = true
    }

    func refreshPage()
    {
        mainView = tabBarController as? MainViewController
        
        if (mainView!.hasNext)
        {
            btn_NextRcrd.isEnabled = true
        }
        else
        {
            btn_NextRcrd.isEnabled = false
        }
        
        if (mainView!.hasBefore)
        {
            btn_PrevRcrd.isEnabled = true
        }
        else
        {
            btn_PrevRcrd.isEnabled = false
        }
        
        lbl_RcrdTotal.text = mainView?.currRcrd
        
    }
}
