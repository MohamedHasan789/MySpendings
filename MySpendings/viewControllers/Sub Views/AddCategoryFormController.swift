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
    
    @IBOutlet weak var txt_CatgIcon: EmojiTextField!
    @IBOutlet weak var txt_CatgName: UITextField!
    @IBOutlet weak var txt_CatgDescription: UITextField!
    @IBOutlet weak var txt_CatgBudget: UITextField!
    @IBOutlet weak var txt_CatgRst: UITextField!
    
    @IBOutlet weak var stch_Budget: UISwitch!
    @IBOutlet weak var stch_Rst: UISwitch!
    @IBOutlet weak var stch_Prmnt: UISwitch!
    @IBOutlet weak var stch_OvBdgt: UISwitch!
    
    @IBOutlet weak var stpr_Budget: UIStepper!
    @IBOutlet weak var stpr_Rst: UIStepper!
    
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
        }
    }
    
    
    func initCatg()
    {
        let retrivedCatg = mainView!.records[mainView!.currRcrd]![catgIndex!]
        
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
        
        if let reset = retrivedCatg.resetCEvery
        {
            txt_CatgRst.backgroundColor = UIColor.quaternaryLabel
            txt_CatgRst.text = "\(reset) Month"
            stpr_Rst.value = Double(reset)
            stch_Rst.isOn = true
            stpr_Rst.isEnabled = true
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
    
    @IBAction func stch_Rst(_ sender: Any)
    {
        if(stch_Rst.isOn)
        {
            enableRest(true)
            if (!stch_Prmnt.isOn)
            {
                stch_Prmnt.setOn(true, animated: true)
            }
        }
        else
        {
            enableRest(false)
        }
    }
    
    @IBAction func stch_Prmnt(_ sender: Any)
    {
        if (!stch_Prmnt.isOn && stch_Rst.isOn)
        {
            enableRest(false)
            stch_Rst.setOn(false, animated: true)
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
                txt_CatgBudget.text = "BHD"
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
    
    func enableRest(_ state: Bool)
    {
        if (state)
        {
            txt_CatgRst.backgroundColor = UIColor.quaternaryLabel
            if (stpr_Rst.value == 1.0)
            {
                txt_CatgRst.text = "\(Int(stpr_Rst.value)) Month"
            }
            else
            {
                txt_CatgRst.text = "\(Int(stpr_Rst.value)) Months"
            }
            
            stpr_Rst.isEnabled = true
        }
        else
        {
            txt_CatgRst.backgroundColor = UIColor.quaternarySystemFill
            txt_CatgRst.text = ""
            stpr_Rst.isEnabled = false
        }
    }
    

    @IBAction func txt_CatgBudgetStart(_ sender: Any)
    {
        if txt_CatgBudget.text == "BHD" || txt_CatgBudget.text == "0.0"
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
    
    
    @IBAction func stpr_Rst(_ sender: Any)
    {
        if (stpr_Rst.value == 1.0)
        {
            txt_CatgRst.text = "\(Int(stpr_Rst.value)) Month"
        }
        else
        {
            txt_CatgRst.text = "\(Int(stpr_Rst.value)) Months"
        }
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
        
        let budget = Double(txt_CatgBudget.text!) ?? nil // force unrawped as value will be 0.0 if user ignores warning, and it will be checked below
        
        var resetEvery: Int? = nil
        
        if (stch_Rst.isOn)
        {
            resetEvery = Int(stpr_Rst.value)
        }
        
        if (stch_Budget.isOn && (budget == 0.0 || txt_CatgBudget.text == "BHD"))
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
                
                let newCategory = Category(icon: icon, name: name, description: description, budget: budget, resetCEvery: resetEvery, permanentategory: permanentCategory, alowOverBudgt: alowOverBudgt, items: items)
                
                mainView?.records[mainView!.currRcrd]?.append(newCategory)
                
                if (permanentCategory)
                {
                    mainView?.prmntCatgrs.append(newCategory)
                }
                

                performSegue(withIdentifier: "unwindToCategories", sender: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Are You Sure?", message: "You cannot undo this edit action.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler:{action in
                    self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].icon = icon
                    self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].name = name
                    self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].description = description
                    self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].budget = budget
                    self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].resetCEvery = resetEvery
                    self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].permanentategory = permanentCategory
                    self.mainView!.records[self.mainView!.currRcrd]![self.catgIndex!].alowOverBudgt = alowOverBudgt
                    
                    
                    self.performSegue(withIdentifier: "unwindToCategories", sender: nil)
                }))
                alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (mainView!.catgChanged)
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
