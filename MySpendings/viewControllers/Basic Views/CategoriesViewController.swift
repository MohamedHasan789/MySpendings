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


class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var view_MainBody: UIView!
    @IBOutlet weak var tblView_Categories: UITableView!
    
    // again jsut teting
    var categories = [catCheck]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageLook()
        poupCategories()
    }
    
    
    // testing for categories
    func poupCategories()
    {
        let test1 = catCheck(catTitle: "Rent", catImage: "🧾")
        let test2 = catCheck(catTitle: "House", catImage: "🏠")
        
        categories.append(test1)
        categories.append(test2)
        
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
         
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // selecion of item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
