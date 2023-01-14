//
//  AddCategoryFormController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class AddCategoryFormController: UIViewController {
    
    var mainView: MainViewController? = nil
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view_MainBody: UIView!
    
    
    @IBOutlet weak var txt_CatgIcon: EmojiTextField!
    @IBOutlet weak var txt_CatgName: UITextField!
    @IBOutlet weak var txt_CatgDescription: UITextField!
    @IBOutlet weak var txt_CatgBudget: UITextField!

    
    @IBOutlet weak var stch_Budget: UISwitch!
    @IBOutlet weak var stch_Prmnt: UISwitch!
    @IBOutlet weak var stch_OvBdgt: UISwitch!
    @IBOutlet weak var stch_fav: UISwitch!
    
    @IBOutlet weak var stpr_Budget: UIStepper!
    
    @IBOutlet weak var btn_Add: UIBarButtonItem!
    
    
    var catgIndex: Int?
    
    var catgEdit: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = tabBarController as? MainViewController
        // Do any additional setup after loading the view.
        keyboardLsnr()
        
        if catgEdit
        {
            initCatg()
            btn_Add.title = "Edit"
            stch_fav.isEnabled = false
        }
        
        if (mainView!.record.favs[mainView!.record.currIndex]?.count == 6)
        {
            stch_fav.isEnabled = false
        }
        
        updateTheme()
    }
    
    func updateTheme()
    {
        view_MainBody.backgroundColor = mainView!.mianColor
    }
    
    func initCatg()
    {
        let retrivedCatg = mainView!.record.records[mainView!.record.currRcrd]![catgIndex!]
        
        txt_CatgIcon.text = retrivedCatg.icon
        txt_CatgName.text = retrivedCatg.name
        
        if let desc = retrivedCatg.description
        {
            txt_CatgDescription.text = desc
        }
        
        if let budget = retrivedCatg.budget
        {
            txt_CatgBudget.backgroundColor = UIColor.quaternaryLabel
            txt_CatgBudget.text = "\(budget)"
            stpr_Budget.value = budget
            stch_Budget.isOn = true
            stpr_Budget.isEnabled = true
        }
        
        
        if (retrivedCatg.permanentategory)
        {
            stch_Prmnt.isOn = true
        }
        
        if (retrivedCatg.alowOverBudgt)
        {
            stch_OvBdgt.isOn = true
        }
    }
    
    
    @IBAction func stch_Budget(_ sender: Any)
    {
        if(stch_Budget.isOn)
        {
            enableBudget(true)
            //set shape things to be on (steppper and stuff)
        }
        else
        {
            // ste them to be off
            enableBudget(false) // the themes set them to off
            
            if (stch_OvBdgt.isOn)
            {
                stch_OvBdgt.setOn(false, animated: true)
            }
        }
    }
    
    
    @IBAction func stch_OvBdgt(_ sender: Any)
    {
        if(stch_OvBdgt.isOn && !stch_Budget.isOn)
        {
            stch_Budget.setOn(true, animated: true)
            enableBudget(true)
        }
    }
    
    func enableBudget(_ state: Bool)
    {
        if (state)
        {
            txt_CatgBudget.backgroundColor = UIColor.quaternaryLabel
            if (stpr_Budget.value == 0)
            {
                txt_CatgBudget.text = mainView!.record.currncy
            }
            else
            {
                txt_CatgBudget.text = "\(stpr_Budget.value)"
            }
            txt_CatgBudget.isEnabled = true
            stpr_Budget.isEnabled = true
        }
        else
        {
            txt_CatgBudget.backgroundColor = UIColor.quaternarySystemFill
            txt_CatgBudget.text = ""
            txt_CatgBudget.isEnabled = false
            stpr_Budget.isEnabled = false
        }
    }
    
    

    @IBAction func txt_CatgBudgetStart(_ sender: Any)
    {
        if txt_CatgBudget.text == mainView!.record.currncy || txt_CatgBudget.text == "0.0"
        {
            txt_CatgBudget.text = ""
        }
    }
    
    @IBAction func txt_CatgBudgetEdit(_ sender: Any)
    {
        if let text = txt_CatgBudget.text, let value = Double(text)
        {
            stpr_Budget.value = value
        }
        else
        {
            let alertController = UIAlertController(title: "Invalid Input", message: "Please input a number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            stpr_Budget.value = 0.0
        }
    }
    
    @IBAction func txt_CatgBudgeDone(_ sender: Any)
    {
        if (stch_Budget.isOn)
        {
            txt_CatgBudget.text = "\(stpr_Budget.value)"
            if (stpr_Budget.value == 0.0)
            {
                txt_CatgBudget.text = ""
            }
        }
    }
    
    
    @IBAction func stpr_Budget(_ sender: Any)
    {
        txt_CatgBudget.text = "\(stpr_Budget.value)"
    }
    
    
    
    @IBAction func btn_AddCategory(_ sender: Any)
    {
        guard let icon = txt_CatgIcon.text,  txt_CatgIcon.text != "" else {
            let alertController = UIAlertController(title: "No Icon Selected", message: "Please choose an icon from the Emoji Keyboard", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            return present(alertController, animated: true, completion: nil)
        }
        
        guard let name = txt_CatgName.text, txt_CatgName.text != "" else {
            let alertController = UIAlertController(title: "No Category Name", message: "Please input a name for the category", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            return present(alertController, animated: true, completion: nil)
        }
        
        let description = txt_CatgDescription.text ?? nil
        
        let permanentCategory = stch_Prmnt.isOn
        let alowOverBudgt = stch_OvBdgt.isOn
        let favCatg = stch_fav.isOn
        
        let budget = Double(txt_CatgBudget.text!) ?? nil // force unrawped as value will be 0.0 if user ignores warning, and it will be checked below
        
        
        if (stch_Budget.isOn && (budget == 0.0 || txt_CatgBudget.text == mainView!.record.currncy))
        {
            let alertController = UIAlertController(title: "Invalid Budget", message: "Please input a valid Budget", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            return present(alertController, animated: true, completion: nil)
        }
        else
        {
            if (!catgEdit)
            {
                let items: [Item] = []
                
                let newCategory = Category(icon: icon, name: name, description: description, budget: budget, permanentategory: permanentCategory, alowOverBudgt: alowOverBudgt, items: items)
                
                mainView?.record.records[mainView!.record.currRcrd]?.append(newCategory)
                
                if (permanentCategory)
                {
                    mainView?.record.prmntCatgrs.append(newCategory)
                }
                
                if (favCatg)
                {
                    let indexOfFav = (mainView?.record.records[mainView!.record.currRcrd]!.count)!
                    mainView?.record.favs[mainView!.record.currIndex]?.append(indexOfFav - 1)
                }

                performSegue(withIdentifier: "unwindToCategories", sender: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Are You Sure?", message: "You cannot undo this edit action.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler:{action in
                    self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!].icon = icon
                    self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!].name = name
                    self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!].description = description
                    self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!].budget = budget
                    self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!].permanentategory = permanentCategory
                    self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!].alowOverBudgt = alowOverBudgt
                    
                    if (self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!].permanentategory)
                    {
                        let catgId = self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!].id
                        
                        let permindex = self.mainView!.record.prmntCatgrs.firstIndex(where: {$0.id == catgId})
                        
                        if let permindex = permindex
                        {
                            self.mainView!.record.prmntCatgrs.remove(at: permindex)
                            self.mainView!.record.prmntCatgrs.insert(self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!], at: permindex)
                        }
                        else
                        {
                            self.mainView!.record.prmntCatgrs.append(self.mainView!.record.records[self.mainView!.record.currRcrd]![self.catgIndex!])
                        }
                    }
                    
                    
                    self.performSegue(withIdentifier: "unwindToCategories", sender: nil)
                }))
                alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (mainView!.record.catgChanged)
        {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
    // known issue for toggle switch https://developer.apple.com/forums/thread/132035
    
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
