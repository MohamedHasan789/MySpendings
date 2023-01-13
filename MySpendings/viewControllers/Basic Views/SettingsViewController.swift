//
//  SettingsViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var mainView: MainViewController?
    
    //list of items in the settings view table
    var stngItems = [stgItem]()
    
    @IBOutlet weak var tblView_Settings: UITableView!
    @IBOutlet weak var view_MainBody: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = tabBarController as? MainViewController
            
        // Do any additional setup after loading the view.
        poupSettings()
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
        view_MainBody.backgroundColor = mainView!.mianColor
    }
    
    func poupSettings()
    {
        stngItems.append(stgItem(itmName: "Theme", itmIcon: UIImage(systemName: "paintpalette")!))
        stngItems.append(stgItem(itmName: "Currancy", itmIcon: UIImage(systemName: "dollarsign.circle")!))
        stngItems.append(stgItem(itmName: "Help", itmIcon: UIImage(systemName: "questionmark.circle")!))
        stngItems.append(stgItem(itmName: "Demo", itmIcon: UIImage(systemName: "purchased.circle")!))
        
        tblView_Settings.dataSource = self
        tblView_Settings.delegate = self
    }
    
    // number of items in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stngItems.count
    }
    
    // actual cells and their info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell")
        cell?.textLabel?.text = stngItems[indexPath.row].itmName
        cell?.imageView?.image = stngItems[indexPath.row].itmIcon
        cell?.accessoryType = .disclosureIndicator;
         
        
        return cell!
    }
    
    // selecion of item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: stngItems[indexPath.row].itmName, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTheme()
    }
    
    
}
