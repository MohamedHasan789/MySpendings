//
//  ItemsViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit


class ItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    
    var mainView: MainViewController?
    

    @IBOutlet weak var btn_Add: UIButton!
    @IBOutlet weak var btn_Edit: UIButton!
    @IBOutlet weak var btn_Delete: UIButton!
    
    @IBOutlet weak var view_MainBody: UIView!
    @IBOutlet weak var tblView_Items: UITableView!
    
    @IBOutlet weak var btn_Sort: UIBarButtonItem!
    
    let searchController = UISearchController()
    
    
    var catgIndex: Int?
    var itemIndex: Int?
    var item: Item? // item to send to views
    
    var editEnable: Bool = false
    var deleteEnable: Bool = false
    
    
    var filterdItems: [Item] = []
    
     
    
    
    var srt_bDate: Bool = false
    var srt_bAlph: Bool = false
    var srt_bPrc: Bool = false
    var srt_bNoi: Bool = false
    
    var srt_Asc: Bool = true
    var srt_Desc: Bool = false
    
    
    var actn_bDate: UIAction? = nil
    var actn_bAlph: UIAction? = nil
    var actn_bPrc: UIAction? = nil
    var actn_bNoi: UIAction? = nil
    
    var actn_Asc: UIAction? = nil
    var actn_Desc: UIAction? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = tabBarController as? MainViewController
        
        pageLook()
        
        
        poupCategories()
        
        initSortMenu()
        rfrshSortMenu()
        

        rfrshTbl()
        
        
        initSearchController()
        
        
        self.title = mainView?.record.records[mainView!.record.currRcrd]?[catgIndex!].name
    }
    
    
    
    @IBAction func btn_Add(_ sender: Any)
    {
        performSegue(withIdentifier: "addItem", sender: nil)
    }
    
    
    // delete multiple items button
    @IBAction func btn_Delete(_ sender: Any) {
        if deleteEnable
        {
            
            tblView_Items.allowsMultipleSelection = true
            let itmstodelete = tblView_Items.indexPathsForSelectedRows
            
            if itmstodelete?.count != nil
            {
                let alert = UIAlertController(title: "Are You Sure?", message: "You cannot undo this action.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{action in
                
                    for indexPath in itmstodelete!
                    {
                        if (self.searchController.isActive)
                        {
                            let obj = self.filterdItems.remove(at: indexPath.row);
                            let indx = self.mainView?.record.records[self.mainView!.record.currRcrd]?[self.catgIndex!].items.firstIndex(where: {$0 == obj}) // fix with opt not ! -- also revert back to the normal list if not avalible
                            self.mainView?.record.records[self.mainView!.record.currRcrd]?[self.catgIndex!].items.remove(at: indx!);
                            self.tblView_Items.deleteRows(at: [indexPath], with: .fade);
                        }
                        else
                        {
                            self.mainView?.record.records[self.mainView!.record.currRcrd]?[self.catgIndex!].items.remove(at: indexPath.row)
                            self.tblView_Items.deleteRows(at: [indexPath], with: .fade);
                        }
                        
                        
                    };
                    self.deleteEnable = false
                    self.tblView_Items.isEditing = false;
                    self.tblView_Items.allowsMultipleSelection = false;
                    self.tblView_Items.reloadData()
                
                }))
                self.tblView_Items.reloadData()
                alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: {action in
                    self.deleteEnable = false;
                    self.tblView_Items.isEditing = false;
                    self.tblView_Items.allowsMultipleSelection = false;
                    self.tblView_Items.reloadData();
                }))
                self.present(alert, animated: true, completion: nil)
                
                tblView_Items.reloadData()
            }
            else
            {
                deleteEnable = false
                tblView_Items.isEditing = false;
                tblView_Items.allowsMultipleSelection = false;
                self.tblView_Items.reloadData();
            }
            
            
            
            
            // chnage the button back to normal colors
            btn_Delete.configuration?.baseForegroundColor = UIColor(red: 0.862, green: 0.115, blue: 0.056, alpha: 1.0)
            btn_Delete.backgroundColor = UIColor.white
        }
        else
        {
            deleteEnable = true
            tblView_Items.allowsMultipleSelection = true
            tblView_Items.isEditing = true
            
            // to chnage button color to red
            btn_Delete.configuration?.baseForegroundColor = UIColor.white
            btn_Delete.backgroundColor = UIColor(red: 0.862, green: 0.115, blue: 0.056, alpha: 1.0)
        }
    }
    
    @IBAction func btn_Edit(_ sender: Any)
    {
        if editEnable
        {
            editEnable = false
            
            btn_Edit.configuration?.baseForegroundColor = UIColor(red: 0.862, green: 0.601, blue: 0.0, alpha: 1.0)
            btn_Edit.backgroundColor = UIColor.white
            
            tblView_Items.reloadData()
        }
        else
        {
            editEnable = true
            
            btn_Edit.configuration?.baseForegroundColor = UIColor.white
            btn_Edit.backgroundColor = UIColor(red: 0.862, green: 0.601, blue: 0.0, alpha: 1.0)
            
            tblView_Items.reloadData()
        }
    }
    
    
    
    func initSortMenu()
    {
        let optionClosure = {(action: UIAction) in self.sortItems(typeName: action.title)}
        
        actn_bDate = UIAction(title: "Date", image: UIImage(systemName: "calendar.circle"), handler: optionClosure)
        actn_bAlph = UIAction(title: "Alphabetical", image: UIImage(systemName: "a.circle"), handler: optionClosure)
        actn_bPrc = UIAction(title: "Total Price", image: UIImage(systemName: "dollarsign.circle"), handler: optionClosure)
        actn_bNoi = UIAction(title: "Number of Items", image: UIImage(systemName: "number.circle"), handler: optionClosure)
        
        actn_Asc = UIAction(title: "Ascending", image: UIImage(systemName: "arrow.up.circle"), handler: optionClosure)
        actn_Desc = UIAction(title: "Descending", image: UIImage(systemName: "arrow.down.circle"), handler: optionClosure)
    }
    
    func rfrshSortMenu()
    {
        let sortingMenu = UIMenu(options: .displayInline, children: [actn_bDate!,actn_bAlph!,actn_bPrc!,actn_bNoi!])
        let assndgMenu = UIMenu(options: .displayInline, children: [actn_Asc!,actn_Desc!])
        
        actn_bDate?.state = UIAction.State.off
        actn_Asc?.state = UIAction.State.off
        actn_Desc?.state = UIAction.State.off
        actn_bAlph?.state = UIAction.State.off
        actn_bPrc?.state = UIAction.State.off
        actn_bNoi?.state = UIAction.State.off
        
        if(srt_bDate)
        {
            actn_bDate?.state = UIAction.State.on
        }
        if (srt_Asc)
        {
            actn_Asc?.state = UIAction.State.on
        }
        if (srt_Desc)
        {
            actn_Desc?.state = UIAction.State.on
        }
        if (srt_bAlph)
        {
            actn_bAlph?.state = UIAction.State.on
        }
        if (srt_bPrc)
        {
            actn_bPrc?.state = UIAction.State.on
        }
        if (srt_bNoi)
        {
            actn_bNoi?.state = UIAction.State.on
        }
        
        btn_Sort.menu = UIMenu(title: "Sort by", children: [sortingMenu, assndgMenu])
        // please note that the warning present during viewing the menu is a known bug https://developer.apple.com/forums/thread/654647, if title is removed it goes :E
    }
    
    func sortItems(typeName: String)
    {
        
        // chnage the booleans (used to chnage menu opteions to on and off) - extra fancy stuff
        if(typeName == "Date")
        {
            srt_bDate = true
            srt_bAlph = false
            srt_bPrc = false
            srt_bNoi = false
        }
        if (typeName == "Alphabetical")
        {
            srt_bAlph = true
            srt_bPrc = false
            srt_bNoi = false
            srt_bDate = false
        }
        else if (typeName == "Total Price")
        {
            srt_bPrc = true
            srt_bAlph = false
            srt_bNoi = false
            srt_bDate = false
        }
        else if (typeName == "Number of Items")
        {
            srt_bNoi = true
            srt_bAlph = false
            srt_bPrc = false
            srt_bDate = false
        }
        
        if (typeName == "Descending")
        {
            srt_Desc = true
            srt_Asc = false
        }
        
        if (typeName == "Ascending")
        {
            srt_Desc = false
            srt_Asc = true
        }
        
        rfrshSortMenu()
        rfrshTbl()
    }
    
    
    func rfrshTbl()
    {
        // sorting function (actully sort the list) - edits the main lists to nigate any idiotic behavior when accsesing index
        if (srt_bDate)
        {
            if(srt_Asc)
            {
                mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items = (mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items.sorted(by: {$0.dateTime < $1.dateTime}))!
            }
            else if (srt_Desc)
            {
                mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items = (mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items.sorted(by: {$0.dateTime > $1.dateTime}))!
            }
        }
        if (srt_bAlph)
        {
            if(srt_Asc)
            {
                mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items = (mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items.sorted(by: <))!
            }
            else if (srt_Desc)
            {
                mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items = (mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items.sorted(by: >))!
            }
        }
        
        if (srt_bPrc)
        {
            if(srt_Asc)
            {
                mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items = (mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items.sorted(by: {$0.getPrice() < $1.getPrice()}))!
            }
            else if (srt_Desc)
            {
                mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items = (mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items.sorted(by: {$0.getPrice() > $1.getPrice()}))!
            }
        }
        
        if (srt_bNoi)
        {
            if(srt_Asc)
            {
                mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items = (mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items.sorted(by: {$0.amount < $1.amount}))!
            }
            else if (srt_Desc)
            {
                mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items = (mainView?.record.records[mainView!.record.currRcrd]![catgIndex!].items.sorted(by: {$0.amount > $1.amount}))!
            }
        }
        
        tblView_Items.reloadData()
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
        
        filterItems(searchText: searchText)
    }
    
    func filterItems(searchText: String)
    {
        filterdItems = (mainView?.record.records[mainView!.record.currRcrd]?[catgIndex!].items.filter {
            itemF in
            let matching = true; if (searchController.searchBar.text != "")
            {
                let mtchngItems = itemF.name.lowercased().contains(searchText.lowercased())
                
                return matching && mtchngItems
            }
            else
            {
                return matching
            }
            
        })!
        tblView_Items.reloadData()
    }
    
    
    //fill in data to the table view
    func poupCategories()
    {
        tblView_Items.dataSource = self
        tblView_Items.delegate = self
    }
    
    
    func pageLook() // to have the fancy look of the application - global - might be chnaged - for the theme options
    {
        view_MainBody.layer.cornerRadius = 45
        view_MainBody.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        view_MainBody.layer.shadowColor = UIColor.black.cgColor
        view_MainBody.layer.shadowOpacity = 0.18
        view_MainBody.layer.shadowRadius = 10
        view_MainBody.layer.shadowOffset = CGSize(width: 0, height: -10)
        
        // round buttons
        btn_Add.layer.cornerRadius = btn_Add.bounds.size.width/2;
        btn_Edit.layer.cornerRadius = btn_Edit.bounds.size.width/2;
        btn_Delete.layer.cornerRadius = btn_Delete.bounds.size.width/2;
        
        updateTheme()
    }
    
    func updateTheme()
    {
        view_MainBody.backgroundColor = mainView!.mianColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive)
        {
            return (filterdItems.count)
        }
        else
        {
            return (mainView?.record.records[mainView!.record.currRcrd]?[catgIndex!].items.count) ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var itemsList = mainView?.record.records[mainView!.record.currRcrd]?[catgIndex!].items
        if (searchController.isActive)
        {
            itemsList = filterdItems
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCard") as! ItemTableViewCell
        
        cell.lbl_Name.text = itemsList![indexPath.row].name
        
        if (!itemsList![indexPath.row].isDeduct)
        {
            cell.img_ItemIcon.image = UIImage(systemName: "cart.badge.plus")
            cell.img_ItemIcon.tintColor = UIColor.systemGreen
        }
        else
        {
            cell.img_ItemIcon.image = UIImage(systemName: "cart.badge.minus")
            cell.img_ItemIcon.tintColor = UIColor.systemRed
        }
        
        cell.lbl_Price.text = "\(itemsList![indexPath.row].getPrice()) \(mainView!.record.currncy)"
        cell.view_CellBody.backgroundColor = mainView!.itemsColor
        
        if editEnable
        {
            cell.img_editIcon.isHidden = false
        }
        else
        {
            cell.img_editIcon.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // deleteing functonanility
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            tableView.beginUpdates()
            
            let alert = UIAlertController(title: "Are You Sure?", message: "You cannot undo this action.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{action in
                if (self.searchController.isActive)
                {
                    let obj = self.filterdItems.remove(at: indexPath.row);
                    let indx = self.mainView?.record.records[self.mainView!.record.currRcrd]?[self.catgIndex!].items.firstIndex(where: {$0 == obj}) // fix with opt not ! -- also revert back to the normal list if not avalible
                    self.mainView?.record.records[self.mainView!.record.currRcrd]?[self.catgIndex!].items.remove(at: indx!);
                    self.tblView_Items.deleteRows(at: [indexPath], with: .fade);
                    self.tblView_Items.reloadData()
                }
                else
                {
                    self.mainView?.record.records[self.mainView!.record.currRcrd]?[self.catgIndex!].items.remove(at: indexPath.row)
                    self.tblView_Items.deleteRows(at: [indexPath], with: .fade);
                    self.tblView_Items.reloadData()
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: {action in self.tblView_Items.reloadData();}))
            self.present(alert, animated: true, completion: nil)
            
            
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    
    
    // editing functonanilty
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") {(action, view, completionHandler) in
            self.itemIndex = indexPath.row
            
            if self.searchController.isActive
            {
                self.itemIndex = self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!].items.firstIndex(where: {$0.id == self.filterdItems[indexPath.row].id})
            }
            
            self.performSegue(withIdentifier: "editItem", sender: nil)
            completionHandler(true)}
        
        let swipe = UISwipeActionsConfiguration(actions: [edit])
        
        
        return swipe
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if (editEnable)
        {
            tableView.deselectRow(at: indexPath, animated: true)
            itemIndex = indexPath.row
            
            if searchController.isActive
            {
                itemIndex = mainView!.record.records[mainView!.record.currRcrd]![catgIndex!].items.firstIndex(where: {$0.id == filterdItems[indexPath.row].id})
            }
            
            performSegue(withIdentifier: "editItem", sender: nil)
        }
        else if (!deleteEnable)
        {
            tableView.deselectRow(at: indexPath, animated: true)
            item = mainView!.record.records[mainView!.record.currRcrd]![catgIndex!].items[indexPath.row]
            
            if searchController.isActive
            {
                item = mainView!.record.records[mainView!.record.currRcrd]![catgIndex!].items[mainView!.record.records[mainView!.record.currRcrd]![catgIndex!].items.firstIndex(where: {$0.id == filterdItems[indexPath.row].id})!]
            }
            
            self.performSegue(withIdentifier: "viewItem", sender: nil)
        }
        
        //go to the view items page info thing
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (mainView!.record.catgChanged)
        {
            self.navigationController?.popToRootViewController(animated: false)
        }
        else
        {
            tblView_Items.reloadData()
        }
        updateTheme()
        rfrshTbl()
    }
    
    
    @IBAction func unwindToItems(_ segue: UIStoryboardSegue)
    {
        
        if editEnable
        {
            editEnable = false
            
            btn_Edit.configuration?.baseForegroundColor = UIColor(red: 0.862, green: 0.601, blue: 0.0, alpha: 1.0)
            btn_Edit.backgroundColor = UIColor.white
        }
        
        tblView_Items.reloadData()
        rfrshTbl()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addItem")
        {
            let addItemsView = segue.destination as! AddItemFormViewController
            addItemsView.catgIndex = catgIndex
        }
        
        if (segue.identifier == "editItem")
        {
            let editItemsView = segue.destination as! AddItemFormViewController
            editItemsView.catgIndex = catgIndex
            editItemsView.itemIndex = itemIndex
            editItemsView.itemEdit = true
        }
        
        if (segue.identifier == "viewItem")
        {
            let viewItemsView = segue.destination as! ViewItemViewController
            viewItemsView.retrivedItem = item
            viewItemsView.mainColor = mainView!.mianColor
        }
    }
    
    @IBAction func hlp(_ sender: Any)
    {
        //self.navigationController?.popToRootViewController(animated: false)

    }
    
    
}
