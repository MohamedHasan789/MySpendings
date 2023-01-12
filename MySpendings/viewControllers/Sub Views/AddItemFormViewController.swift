//
//  AddItemFormViewController.swift
//  MySpendings
//
//  Created by Mohamed on 10/01/2023.
//

import UIKit

class AddItemFormViewController: UIViewController {
    
    var mainView: MainViewController? = nil
    
    var catgIndex: Int?
    
    var itemEdit: Bool = false
    var itemIndex: Int?

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txt_ItemIcon: EmojiTextField!
    @IBOutlet weak var txt_ItemName: UITextField!
    @IBOutlet weak var txt_ItemPrice: UITextField!
    @IBOutlet weak var txt_ItemAmount: UITextField!
    
    @IBOutlet weak var dat_ItemDate: UIDatePicker!
    
    @IBOutlet weak var stpr_Price: UIStepper!
    @IBOutlet weak var stpr_Amount: UIStepper!
    
    @IBOutlet weak var stch_ItemType: UISegmentedControl!
    
    @IBOutlet weak var btn_Add: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        keyboardLsnr()
        
        mainView = tabBarController as? MainViewController
        
        if itemEdit
        {
            initItem()
            btn_Add.title = "Edit"
            self.title = "Edit \(mainView!.records[mainView!.currRcrd]![catgIndex!].items[itemIndex!].name)"
        }
        
        //print(catgIndex)
    }
    
    
    func initItem()
    {
        let retrivedItem = mainView!.records[mainView!.currRcrd]![catgIndex!].items[itemIndex!]
        
        txt_ItemIcon.text = retrivedItem.icon
        txt_ItemName.text = retrivedItem.name
        txt_ItemPrice.text = "\(retrivedItem.price)"
        txt_ItemAmount.text = "\(retrivedItem.amount)"
        
        dat_ItemDate.date = retrivedItem.dateTime
        
        stpr_Price.value = retrivedItem.price
        stpr_Amount.value = Double(retrivedItem.amount)
        
        stch_ItemType.selectedSegmentIndex = 0
        if (!retrivedItem.isDeduct)
        {
            stch_ItemType.selectedSegmentIndex = 1
        }
    }
    
    
    @IBAction func txt_ItemPriceEdit(_ sender: Any)
    {
        if let text = txt_ItemPrice.text, let value = Double(text)
        {
            stpr_Price.value = value
        }
        else
        {
            let alertController = UIAlertController(title: "Invalid Input", message: "Please input a number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            stpr_Price.value = 0.0
        }
    }
    
    @IBAction func txt_ItemPriceDone(_ sender: Any)
    {
        txt_ItemPrice.text = "\(stpr_Price.value)"
        if (stpr_Price.value == 0.0)
        {
            txt_ItemPrice.text = ""
        }
    }
    
    
    
    @IBAction func txt_ItemAmountEdit(_ sender: Any)
    {
        if let text = txt_ItemAmount.text, let value = Double(text)
        {
            stpr_Amount.value = value
        }
        else
        {
            let alertController = UIAlertController(title: "Invalid Input", message: "Amount cannot be less than 1", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            stpr_Amount.value = 1
        }
    }
    
    @IBAction func txt_ItemAmountDone(_ sender: Any)
    {
        txt_ItemAmount.text = "\(Int(stpr_Amount.value))"
    }
    
    
    
    @IBAction func stpr_Price(_ sender: Any)
    {
        txt_ItemPrice.text = "\(stpr_Price.value)"
    }
    
    @IBAction func stpr_Amount(_ sender: Any)
    {
        txt_ItemAmount.text = "\(Int(stpr_Amount.value))"
    }
    
    
    @IBAction func btn_AddItem(_ sender: Any)
    {
        guard let icon = txt_ItemIcon.text,  txt_ItemIcon.text != "" else {
            let alertController = UIAlertController(title: "No Icon Selected", message: "Please choose an icon from the Emoji Keyboard", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            return present(alertController, animated: true, completion: nil)
        }
        
        guard let name = txt_ItemName.text, txt_ItemName.text != "" else {
            let alertController = UIAlertController(title: "No Item Name", message: "Please input a name for the Item", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            return present(alertController, animated: true, completion: nil)
        }
        
        guard let text = txt_ItemPrice.text, txt_ItemPrice.text != "", txt_ItemPrice.text != "0.0", let price = Double(text) else {
            let alertController = UIAlertController(title: "No Item Price", message: "Please input a price for the Item", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            return present(alertController, animated: true, completion: nil)
        }
        
        let amount = Int(txt_ItemAmount.text!)! // force unrwaped as it the user will not be able to input no value less than 1 bu view and above guard
        
        var isDeduct = true
        
        if (stch_ItemType.selectedSegmentIndex == 1)
        {
            isDeduct = false
        }
        
        let date = dat_ItemDate.date
        
        if (!itemEdit)
        {
            let newItem = Item(icon: icon, name: name, isDeduct: isDeduct, price: price, amount: amount, dateTime: date)
            
            mainView?.records[mainView!.currRcrd]?[catgIndex!].items.append(newItem)
            
            performSegue(withIdentifier: "unwindToItems", sender: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Are You Sure?", message: "You cannot undo this edit action.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler:{action in
                self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].items[self.itemIndex!].icon = icon
                self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].items[self.itemIndex!].name = name
                self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].items[self.itemIndex!].isDeduct = isDeduct
                self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].items[self.itemIndex!].price = price
                self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].items[self.itemIndex!].amount = amount
                self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].items[self.itemIndex!].dateTime = date
                
                self.performSegue(withIdentifier: "unwindToItems", sender: nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (mainView!.catgChanged)
        {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    func keyboardLsnr(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: (keyboardSize.height - (self.tabBarController!.tabBar.frame.size.height)) , right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
    }
    
    

    

}
