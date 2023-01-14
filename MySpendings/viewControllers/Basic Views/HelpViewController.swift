//
//  HelpViewController.swift
//  MySpendings
//
//  Created by Mohamed on 13/01/2023.
//

import UIKit

class HelpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    var mainView: MainViewController?
    
    @IBOutlet weak var tblView_Help: UITableView!
    @IBOutlet weak var view_MainBody: UIView!
    
    var hlpItems = [hlpItem]()
    
    let searchController = UISearchController()
    
    var filterdHelps: [hlpItem] = []
    
    var prevRow: IndexPath = IndexPath(row: -1, section: -1)
    var selectedRow: IndexPath = IndexPath(row: -1, section: -1)
    var isExpanded:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = tabBarController as? MainViewController
        
        
        // Do any additional setup after loading the view.
        poupHelp()
        
        initSearchController()
        
        pageLook()
        
        tblView_Help.estimatedRowHeight = 200
        tblView_Help.rowHeight = UITableView.automaticDimension
    }
    
    
    // implemented from https://www.youtube.com/watch?v=DAHG0orOxKo
    func initSearchController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        
        filterHelps(searchText: searchText)
    }
    
    
    func filterHelps(searchText: String)
    {
        filterdHelps = hlpItems.filter
                       {
            HelpT in
            let matching = true; if (searchController.searchBar.text != "")
            {
                let mtchngHelp = HelpT.itmTitle.lowercased().contains(searchText.lowercased())
                
                return matching && mtchngHelp
            }
            else
            {
                return matching
            }
            
        }
        
        tblView_Help.reloadData()
    }
    
    
    
    func poupHelp()
    {
        hlpItems.append(hlpItem(itmTitle: "Adding a Category", itmBody: "Click on the + sign in the categories page to be able to add new categories to the application. You can select permanent to automatically add the category every month. each category can have a budget or can even be reset for a spisific amount of months if you selcted it as a permanent category"))
        hlpItems.append(hlpItem(itmTitle: "Editing a Category", itmBody: "While viewing the list of categories, choose the edit button of whichever catgory you wish to modify, or swipe from the left side for the category you want to edit"))
        hlpItems.append(hlpItem(itmTitle: "Deleteing a Category", itmBody: "While viewing the list of categories, or swipe from the right side for the category you want to delete"))
        hlpItems.append(hlpItem(itmTitle: " Viewing an item ", itmBody: "In the categories page, to view an item for any specific category, click on the category you want to view the items for, and from there a list of items for that specific category will be displayed, here you can scroll anyway you like to see  items. "))
        hlpItems.append(hlpItem(itmTitle: " Viewing details of an item", itmBody: "In the items page of a specific category, click on any item you wish to see the details of, and popup will display the information of the item you clicked. "))
        hlpItems.append(hlpItem(itmTitle: " Adding an item", itmBody: "In the categories page, to add an item for any specific category, click on the category you want to add items to, and from there you fill out the details of the item, once you are done adding information click on the ‘Add’ button on the top right of the screen and then the item will be added to the category you selected. "))
        hlpItems.append(hlpItem(itmTitle: " Editing an item", itmBody: "You can edit an item in 2 ways, the first way is by sliding on the item from the left and from there you can edit the item, the second way is by clicking the yellow pencil button and selecting which item you want to edit, click Edit once done. "))
        hlpItems.append(hlpItem(itmTitle: " Deleting an item", itmBody: "You can delete an item in 2 ways, first is by sliding on the item from the right which will delete it, second is clicking on the red trash icon button and it will allow you to select how ever many items you want to delete. "))
        hlpItems.append(hlpItem(itmTitle: " Changing the app theme", itmBody: "Click on Theme button in the settings app, and from there you can set 3 colors to your choosing, once clicked on any of the 3 ways of changing the color you are presented with a screen that allows you to pick which colors you want, the changes get saved as soon as you click on which color you want. "))
        hlpItems.append(hlpItem(itmTitle: " Changing the app Currency", itmBody: "Click on the Currency button in the settings app, and then select the currency you want. "))
        hlpItems.append(hlpItem(itmTitle: " Changing the monthly Record", itmBody: "In the home page you can select which months you want to see your records on, and the categories you created on that specific month will show up in the categories tab. "))
        
        
        tblView_Help.dataSource = self
        tblView_Help.delegate = self
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive)
        {
            return filterdHelps.count
        }
        return hlpItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var helpList = hlpItems
        if searchController.isActive
        {
            helpList = filterdHelps
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandCell") as! HelpTableViewCell
        cell.lbl_Title.text = helpList[indexPath.row].itmTitle
        cell.lbl_Body.text = helpList[indexPath.row].itmBody
        
        if selectedRow == indexPath
        {
            cell.img_Chevron.image = UIImage(systemName: "chevron.down")
            cell.lbl_Body.isHidden = false
        }
        else
        {
            cell.img_Chevron.image = UIImage(systemName: "chevron.right")
            cell.lbl_Body.isHidden = true
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (selectedRow == indexPath)
        {
            return 200
        }
        else
        {
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        prevRow = selectedRow
        selectedRow = indexPath
        
        if prevRow != IndexPath(row: -1, section: -1)
        {
            tableView.reloadRows(at: [prevRow], with: .automatic)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTheme()
    }
    

}
