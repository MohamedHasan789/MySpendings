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

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var view_MainBody: UIView!
    @IBOutlet weak var tblView_Categories: UITableView!
    
    // again jsut teting
    
    
    
    var categories = [test1,test2]
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageLook()
        poupCategories()
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

    
    // number of items in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    // actual cells and their info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCard") as! CategoryTableViewCell
        
        cell.lbl_Name.text = categories[indexPath.row].catTitle
        cell.img_CatIcon.text = categories[indexPath.row].catImage
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
        return .delete
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
}
