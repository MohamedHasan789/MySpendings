//
//  ItemsViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit


// testing class - to check ctageory items
class itemCheck
{
    var itemImage: UIImage
    var itemTitle: String
    var itemPrice: String
    
    init(itemImage: UIImage, itemTitle: String, itemPrice: String)
    {
        self.itemImage = itemImage
        self.itemTitle = itemTitle
        self.itemPrice = itemPrice
    }
}

let item1 = itemCheck(itemImage: UIImage(systemName: "cart.badge.plus")!, itemTitle: "edumamy", itemPrice: "15.88 BHD")
let item2 = itemCheck(itemImage: UIImage(systemName: "cart.badge.minus")!, itemTitle: "zift", itemPrice: "-47.55 BHD")
let item3 = itemCheck(itemImage: UIImage(systemName: "cart.badge.plus")!, itemTitle: "Refund", itemPrice: "78.88 BHD")
let item4 = itemCheck(itemImage: UIImage(systemName: "cart.badge.plus")!, itemTitle: "edumamy", itemPrice: "15.88 BHD")
let item5 = itemCheck(itemImage: UIImage(systemName: "cart.badge.minus")!, itemTitle: "zift", itemPrice: "-47.55 BHD")
let item6 = itemCheck(itemImage: UIImage(systemName: "cart.badge.plus")!, itemTitle: "Refund", itemPrice: "78.88 BHD")
let item7 = itemCheck(itemImage: UIImage(systemName: "cart.badge.minus")!, itemTitle: "zift", itemPrice: "-47.55 BHD")
let item8 = itemCheck(itemImage: UIImage(systemName: "cart.badge.plus")!, itemTitle: "Refund", itemPrice: "78.88 BHD")


class ItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    //var catgoryName: String
    @IBOutlet weak var btn_Add: UIButton!
    @IBOutlet weak var btn_Edit: UIButton!
    @IBOutlet weak var btn_Delete: UIButton!
    
    @IBOutlet weak var view_MainBody: UIView!
    @IBOutlet weak var tblView_Items: UITableView!
    
    
    //testing
    var itemsList = [item1,item2,item3,item4,item5,item6,item7,item8,item1,item2]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.title = catgoryName
        btn_Add.layer.cornerRadius = btn_Add.bounds.size.width/2;
        btn_Edit.layer.cornerRadius = btn_Edit.bounds.size.width/2;
        btn_Delete.layer.cornerRadius = btn_Delete.bounds.size.width/2;
        
        pageLook()
        poupCategories()
    }
    
    
    @IBAction func btn_Delete(_ sender: Any) {
        if tblView_Items.isEditing
        {
            let itmstodelete = tblView_Items.indexPathsForSelectedRows
            
            for item in itmstodelete!
            {
                self.itemsList.remove(at: item.row);
                tblView_Items.deleteRows(at: [item], with: .fade);
            }
            
            tblView_Items.isEditing = false
        }
        else
        {
            tblView_Items.isEditing = true
        }
    }
    
    
    
    
    
    func poupCategories()
    {
        
        tblView_Items.dataSource = self
        tblView_Items.delegate = self
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
    
    /*
    init?(coder: NSCoder, catgoryName: String)
    {
        self.catgoryName = catgoryName
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCard") as! ItemTableViewCell
        
        cell.lbl_Name.text = itemsList[indexPath.row].itemTitle
        cell.img_ItemIcon.image = itemsList[indexPath.row].itemImage
        cell.lbl_Price.text = itemsList[indexPath.row].itemPrice
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
