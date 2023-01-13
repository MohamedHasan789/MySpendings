//
//  ViewCategoryViewController.swift
//  MySpendings
//
//  Created by Mohamed on 13/01/2023.
//

import UIKit

class ViewCategoryViewController: UIViewController {
    
    var retrivedCatg: Category?
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var txt_Icon: UITextField!
    @IBOutlet weak var txt_Desc: UITextField!
    @IBOutlet weak var txt_Budget: UITextField!
    @IBOutlet weak var txt_Rst: UITextField!
    @IBOutlet weak var txt_Prmnnt: UITextField!
    @IBOutlet weak var txt_AlertOvBdg: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCatgeory()
    }
    
    func getCatgeory()
    {
        
        lbl_Name.text = retrivedCatg?.name
        txt_Icon.text = retrivedCatg?.icon
        
        if let desc = retrivedCatg?.description, desc != ""
        {
            txt_Desc.text = desc
            txt_Desc.backgroundColor = UIColor.quaternaryLabel
        }
        
        if let bdgt = retrivedCatg?.budget
        {
            txt_Budget.text = "\(bdgt)"
            txt_Budget.backgroundColor = UIColor.quaternaryLabel
        }
        
        if let rst = retrivedCatg?.resetCEvery
        {
            if rst == 1
            {
                txt_Rst.text = "\(rst) Month"
            }
            else
            {
                txt_Rst.text = "\(rst) Months"
            }
            txt_Rst.backgroundColor = UIColor.quaternaryLabel
        }
        
        if retrivedCatg!.permanentategory
        {
            txt_Prmnnt.text = "Yes"
            txt_Prmnnt.backgroundColor = UIColor.quaternaryLabel
        }
        
        if retrivedCatg!.alowOverBudgt
        {
            txt_AlertOvBdg.text = "Yes"
            txt_AlertOvBdg.backgroundColor = UIColor.quaternaryLabel
        }
    }

}
