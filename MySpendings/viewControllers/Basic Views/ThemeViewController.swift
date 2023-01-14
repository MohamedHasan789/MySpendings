//
//  ThemeViewController.swift
//  MySpendings
//
//  Created by Mohamed on 13/01/2023.
//

// **PLEASE NOTE** //
// as that "mainView" is the tabbar controller and will always be present no matter which view the user is in, it will be force unrapwd for the entirity if the application, this is done to nigate the extra "14251" lines of code requiried for each entry of the "mainView!"
// **PLEASE NOTE** //

import UIKit

class ThemeViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    //implemented from https://www.swiftpal.io/articles/how-to-use-uicolorpickerviewcontroller-in-swift
    
    var mainView: MainViewController?
    
    @IBOutlet weak var view_MainBody: UIView!
    
    @IBOutlet weak var btn_MainColor: UIButton!
    @IBOutlet weak var btn_ScndColor: UIButton!
    @IBOutlet weak var btn_ItmsColor: UIButton!
    
    var mainColorEdit = false
    var scndColorEdit = false
    var itmColorEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = tabBarController as? MainViewController
        
        // Do any additional setup after loading the view.
        pageLook()
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
        btn_MainColor.tintColor = mainView!.mianColor
        
        btn_ScndColor.tintColor = mainView!.scndColor
        
        btn_ItmsColor.tintColor = mainView!.itemsColor
        
        view_MainBody.backgroundColor = mainView!.mianColor
    }
    
    @IBAction func btn_MainColor(_ sender: Any)
    {
        mainColorEdit = true
        // Initializing Color Picker
        let picker = UIColorPickerViewController()

        // Setting the Initial Color of the Picker
        picker.selectedColor = mainView!.mianColor

        // Setting Delegate
        picker.delegate = self

        // Presenting the Color Picker
        self.present(picker, animated: true, completion: {})
    }
    
    @IBAction func btn_ScndColor(_ sender: Any)
    {
        scndColorEdit = true
        let picker = UIColorPickerViewController()

        picker.selectedColor = mainView!.scndColor
        picker.delegate = self

        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func btn_ItmsColor(_ sender: Any)
    {
        itmColorEdit = true
        let picker = UIColorPickerViewController()

        picker.selectedColor = mainView!.itemsColor
        picker.delegate = self

        self.present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func btn_ResetAll(_ sender: Any)
    {
        mainView!.mianColor = UIColor(red: 0.891, green: 0.999, blue: 0.856, alpha: 1.0)
        mainView!.scndColor = UIColor(red: 0.787, green: 0.998, blue: 0.718, alpha: 1.0)
        mainView!.itemsColor = UIColor.white
        
        updateTheme()
    }
    
    
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        if mainColorEdit
        {
            mainView!.mianColor = viewController.selectedColor
            mainColorEdit = false
        }
        else if (scndColorEdit)
        {
            mainView!.scndColor = viewController.selectedColor
            scndColorEdit = false
        }
        else if (itmColorEdit)
        {
            mainView!.itemsColor = viewController.selectedColor
            itmColorEdit = false
        }
        
        updateTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        updateTheme()
        Record.saveRocrd(mainView!.record)
    }
    
}
