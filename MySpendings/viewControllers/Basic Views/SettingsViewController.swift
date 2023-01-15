//
//  SettingsViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

// **PLEASE NOTE** //
// as that "mainView" is the tabbar controller and will always be present no matter which view the user is in, it will be force unrapwd for the entirity if the application, this is done to nigate the extra "14251" lines of code requiried for each entry of the "mainView!"
// **PLEASE NOTE** //

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
    
    // to have the fancy look of the application
    func pageLook()
    {
        view_MainBody.layer.cornerRadius = 45
        view_MainBody.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        view_MainBody.layer.shadowColor = UIColor.black.cgColor
        view_MainBody.layer.shadowOpacity = 0.18
        view_MainBody.layer.shadowRadius = 10
        view_MainBody.layer.shadowOffset = CGSize(width: 0, height: -10)
        
        updateTheme()
    }
    
    // update the colors of the page
    func updateTheme()
    {
        view_MainBody.backgroundColor = mainView!.mianColor
    }
    
    // function to declare tableview datasources
    func poupSettings()
    {
        stngItems.append(stgItem(itmName: "Theme", itmIcon: UIImage(systemName: "paintpalette")!))
        stngItems.append(stgItem(itmName: "Currancy", itmIcon: UIImage(systemName: "dollarsign.circle")!))
        stngItems.append(stgItem(itmName: "Help", itmIcon: UIImage(systemName: "questionmark.circle")!))
        
        tblView_Settings.dataSource = self
        tblView_Settings.delegate = self
    }
    
    // rate and msg btns actions
    @IBAction func btn_Heart(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Rate Us", message: "so 5 star review?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let canAction = UIAlertAction(title: "NO", style: .destructive, handler: nil)
        alertController.addAction(defaultAction)
        alertController.addAction(canAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btn_MsgUs(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Contact Us", message: "Email 202002789", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
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
    
    // call the refresh methods whenever the page is loaded
    override func viewWillAppear(_ animated: Bool) {
        updateTheme()
        
        Record.saveRocrd(mainView!.record)
    }
}
