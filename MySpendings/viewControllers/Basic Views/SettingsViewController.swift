//
//  SettingsViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

//setting items class definitation
class stgItem
{
    var itmName: String
    var itmIcon: UIImage
    
    init(itmName: String, itmIcon: UIImage)
    {
        self.itmName = itmName
        self.itmIcon = itmIcon
    }
    
}

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    //list of items in the settings view table
    var stngItems = [stgItem]()
    
    @IBOutlet weak var tblView_Settings: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        poupSettings()
        
    }
    
    
    func poupSettings()
    {
        let helpItm = stgItem(itmName: "help", itmIcon: UIImage(systemName: "questionmark.circle")!)
        let currItm = stgItem(itmName: "currancy", itmIcon: UIImage(systemName: "dollarsign.circle")!)
        stngItems.append(helpItm)
        stngItems.append(currItm)
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "settingstable")
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "settingstable")
        }
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
    
    
}
