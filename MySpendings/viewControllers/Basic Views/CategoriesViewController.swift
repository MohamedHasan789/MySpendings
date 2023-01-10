//
//  CategoriesViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit


// testing class - to check ctageory items
class catCheck
{
    var catTitle: String
    var catImage: String
    
    init(catTitle: String, catImage: String)
    {
        self.catTitle = catTitle
        self.catImage = catImage
    }
}


let test1 = catCheck(catTitle: "Rent", catImage: "🧾")
let test2 = catCheck(catTitle: "House", catImage: "🏠")

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate
{
    
    
    
    @IBOutlet weak var view_MainBody: UIView!
    @IBOutlet weak var tblView_Categories: UITableView!
    
    @IBOutlet weak var btn_Sort: UIBarButtonItem!
    
    
    // again jsut teting
    var categories = [test1,test2]
    var filterdCats: [catCheck] = []
    
    
    let searchController = UISearchController()
    
    var srt_bAlph: Bool = true
    var srt_bPrc: Bool = false
    var srt_bNoi: Bool = false
    
    var srt_Asc: Bool = true
    var srt_Desc: Bool = false

    
    
    
    
    var actn_bAlph: UIAction? = nil
    var actn_bPrc: UIAction? = nil
    var actn_bNoi: UIAction? = nil
    
    var actn_Asc: UIAction? = nil
    var actn_Desc: UIAction? = nil

    
    //frstaction.state = UIMenuElement.State.on
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageLook()
        poupCategories()
        
        initSortMenu()
        rfrshSortMenu()
        
        // to load defult sorting abc asc
        rfrshTbl()
        
        
        initSearchController()
    }
    
    func initSortMenu()
    {
        let optionClosure = {(action: UIAction) in self.sortCats(typeName: action.title)}
        
        actn_bAlph = UIAction(title: "Alphabetical", image: UIImage(systemName: "a.circle"), handler: optionClosure)
        actn_bPrc = UIAction(title: "Total Price", image: UIImage(systemName: "dollarsign.circle"), handler: optionClosure)
        actn_bNoi = UIAction(title: "Number of Items", image: UIImage(systemName: "number.circle"), handler: optionClosure)
        
        actn_Asc = UIAction(title: "Ascending", image: UIImage(systemName: "arrow.up.circle"), handler: optionClosure)
        actn_Desc = UIAction(title: "Descending", image: UIImage(systemName: "arrow.down.circle"), handler: optionClosure)
    }
    
    func rfrshSortMenu()
    {
        let sortingMenu = UIMenu(options: .displayInline, children: [actn_bAlph!,actn_bPrc!,actn_bNoi!])
        let assndgMenu = UIMenu(options: .displayInline, children: [actn_Asc!,actn_Desc!])
        
        actn_Asc?.state = UIAction.State.off
        actn_Desc?.state = UIAction.State.off
        actn_bAlph?.state = UIAction.State.off
        actn_bPrc?.state = UIAction.State.off
        actn_bNoi?.state = UIAction.State.off
        
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
    
    func sortCats(typeName: String)
    {
        
        // chnage the booleans (used to chnage menu opteions to on and off) - extra fancy stuff
        if (typeName == "Alphabetical")
        {
            srt_bAlph = true
            srt_bPrc = false
            srt_bNoi = false
        }
        else if (typeName == "Total Price")
        {
            srt_bPrc = true
            srt_bAlph = false
            srt_bNoi = false
        }
        else if (typeName == "Number of Items")
        {
            srt_bNoi = true
            srt_bAlph = false
            srt_bPrc = false
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
        // sorting function (actully sort the list)
        if (srt_bAlph)
        {
            if(srt_Asc)
            {
                categories = categories.sorted(by: {$0.catTitle < $1.catTitle})
            }
            else if (srt_Desc)
            {
                categories = categories.sorted(by: {$0.catTitle > $1.catTitle})
            }
        }
        
        if (srt_bPrc)
        {
            if(srt_Asc)
            {
                
            }
            else if (srt_Desc)
            {
                
            }
        }
        
        if (srt_bNoi)
        {
            if(srt_Asc)
            {
                
            }
            else if (srt_Desc)
            {
                
            }
        }
        
        tblView_Categories.reloadData()
    }
    
    
    // testing for categories
    func poupCategories()
    {
        
        tblView_Categories.dataSource = self
        tblView_Categories.delegate = self

    }
    
    
    func pageLook() // to have the fancy look of the application
    {
        view_MainBody.layer.cornerRadius = 45
        view_MainBody.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        view_MainBody.layer.shadowColor = UIColor.black.cgColor
        view_MainBody.layer.shadowOpacity = 0.18
        view_MainBody.layer.shadowRadius = 10
        view_MainBody.layer.shadowOffset = CGSize(width: 0, height: -10)
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
        
        filterCats(searchText: searchText)
    }
    
    
    func filterCats(searchText: String)
    {
        filterdCats = categories.filter
        {
            categoryT in
            let matching = true; if (searchController.searchBar.text != "")
            {
                let mtchngCats = categoryT.catTitle.lowercased().contains(searchText.lowercased())
                
                return matching && mtchngCats
            }
            else
            {
                return matching
            }
            
        }
        tblView_Categories.reloadData()
    }
    
    
    // number of items in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive)
        {
            return filterdCats.count
        }
        return (categories.count)+1
    }
    
    // actual cells and their info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var categoriesLsit = categories
        if (searchController.isActive)
        {
            categoriesLsit = filterdCats
        }
        
        if (!(searchController.isActive))
        {
            if (indexPath.row == categories.count)
            {
                let cell = tblView_Categories.dequeueReusableCell(withIdentifier: "addCard")
                return cell!
            }
        }
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCard") as! CategoryTableViewCell
            
            cell.lbl_Name.text = categoriesLsit[indexPath.row].catTitle
            cell.img_CatIcon.text = categoriesLsit[indexPath.row].catImage
            cell.lbl_Items.text = "5"
            cell.lbl_Total.text = "10"
             
            cell.btn_Info.addTarget(self, action: #selector(infoCat(sender:)), for: .touchUpInside)
            cell.btn_Edit.addTarget(self, action: #selector(editCat(sender:)), for: .touchUpInside)
            
            cell.btn_Info.tag = indexPath.row
            cell.btn_Edit.tag = indexPath.row
            return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // selecion of item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            tableView.beginUpdates()
            
            let alert = UIAlertController(title: "Are You Sure?", message: "You cannot undo this action.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{action in
                self.categories.remove(at: indexPath.row);
                tableView.deleteRows(at: [indexPath], with: .fade);
            }))
            alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if (indexPath.row == categories.count)
        {
            return .none
        }
        else
        {
            return .delete
        }
    }
    
    
    // editing functonanilty
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if (indexPath.row == categories.count)
        {
            return nil
        }
        else
        {
            let edit = UIContextualAction(style: .normal, title: "Edit") {(action, view, completionHandler) in print("editing \(indexPath.row)"); completionHandler(true)}
            
            let swipe = UISwipeActionsConfiguration(actions: [edit])
            
            return swipe
        }
    }
    
    @objc
    func infoCat(sender:UIButton)
    {
        print("info for:")
        print(sender.tag)
    }
    
    @objc
    func editCat(sender:UIButton)
    {
        print("edit for:")
        print(sender.tag)
    }
    
    // footer for table (easy add button)
    /*
    // the add button at the end - removed as it has a bug when using cells - apple issue, implemented within each function (view, edit delet)
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            
            let cell = tblView_Categories.dequeueReusableCell(withIdentifier: "addCard")
            return cell
    }


    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 150
    }
     */

    @objc
    func handle(sender: UIButton) {
        print("Tapped")
    }
    
    
}
