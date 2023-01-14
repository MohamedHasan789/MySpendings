//
//  CurrancyViewController.swift
//  MySpendings
//
//  Created by Mohamed on 13/01/2023.
//

// **PLEASE NOTE** //
// as that "mainView" is the tabbar controller and will always be present no matter which view the user is in, it will be force unrapwd for the entirity if the application, this is done to nigate the extra "14251" lines of code requiried for each entry of the "mainView!"
// **PLEASE NOTE** //

import UIKit

class CurrancyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    var mainView: MainViewController?
    
    let currancies = ["BHD د.ب","SAR ﷼","USD $","EUR €","PND £","FRN ₣","RPE ₹"]
    
    @IBOutlet weak var view_MainBody: UIView!
    @IBOutlet weak var pkr_CurncSelect: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = tabBarController as? MainViewController

        // Do any additional setup after loading the view.
        pageLook()
        poupPicker()
    }
    
    func poupPicker()
    {
        pkr_CurncSelect.delegate = self
        pkr_CurncSelect.dataSource = self
        
        pkr_CurncSelect.selectRow(mainView!.record.currncyIndex, inComponent: 0, animated: true)
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
    
    override func viewWillAppear(_ animated: Bool)
    {
        updateTheme()
        
        updateTheme()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currancies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currancies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mainView!.record.currncy = currancies[row]
        mainView!.record.currncyIndex = row
    }
    
    

}
