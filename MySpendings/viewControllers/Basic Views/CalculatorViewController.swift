//
//  CalculatorViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//


// **PLEASE NOTE** //
// as that "mainView" is the tabbar controller and will always be present no matter which view the user is in, it will be force unrapwd for the entirity if the application, this is done to nigate the extra "14251" lines of code requiried for each entry of the "mainView!"
// **PLEASE NOTE** //

import UIKit
import SwiftUI

class CalculatorViewController: UIViewController {

    var mainView: MainViewController?
    @IBOutlet weak var stch_CalcSelc: UISegmentedControl!
    
    @IBOutlet weak var view_MainBody: UIView!
    
    @IBOutlet weak var view_NormalCalc: UIView!
    @IBOutlet weak var lbl_NormalCalcOut: UILabel!
    @IBOutlet weak var btn_nrmlAc: UIButton!
    
    
    @IBOutlet weak var view_SavingsCalc: UIView!
    
        
    //normal calc stuff
    var savedValue: Double = 0.0;
    var currValue: Double = 0.0;
    
    var inputValue: String = "";
    var lastUsedFunc: String = "";
    
    
    //savings calc stuff
    @IBOutlet weak var txt_AmntSave: UITextField!
    @IBOutlet weak var txt_Salary: UITextField!
    @IBOutlet weak var txt_SalCut: UITextField!
    @IBOutlet weak var txt_SalInc: UITextField!
    
    @IBOutlet weak var stpr_AmntSaved: UIStepper!
    @IBOutlet weak var stpr_Salary: UIStepper!
    @IBOutlet weak var stpr_SalCat: UIStepper!
    @IBOutlet weak var stpr_SalInc: UIStepper!
    
    @IBOutlet weak var stch_SalInc: UISwitch!
    
    @IBOutlet weak var lbl_Period: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = tabBarController as? MainViewController
        
        
        // Do any additional setup after loading the view.
        pageLook()
    }
    
    
    // switch btwn calcs
    @IBAction func stch_CalcSelc(_ sender: Any)
    {
        if stch_CalcSelc.selectedSegmentIndex == 0
        {
            view_NormalCalc.isHidden = false
            view_SavingsCalc.isHidden = true
        }
        else
        {
            view_NormalCalc.isHidden = true
            view_SavingsCalc.isHidden = false
        }
    }
    
    
    // normal calc buttons and functions
    @IBAction func btn_Number(_ sender: UIButton, forEvent event: UIEvent)
    {
        let number = sender.titleLabel?.text!
        inputValue.append(number!)
        convertToDouble(inputValue, "currValue");
        displayNumbers()
        
    }
    
    @IBAction func btn_comm(_ sender: Any)
    {
        inputValue.append(".")
        convertToDouble(inputValue, "currValue");
        displayNumbers()
    }
    
    @IBAction func btn_clr(_ sender: Any)
    {
        inputValue = ""
        if currValue > 0.0
        {
            currValue = 0.0
        }
        else
        {
            currValue = 0.0
            savedValue = 0.0
        }
        displayNumbers()
    }
    
    @IBAction func btn_flip(_ sender: Any)
    {
        currValue *= -1;
        displayNumbers();
    }
    
    @IBAction func btn_perc(_ sender: Any)
    {
        currValue /= 100;
        displayNumbers();
    }
    
    @IBAction func btn_dvd(_ sender: Any)
    {
        if savedValue == 0.0
        {
            savedValue = currValue;
        }
        else
        {
            savedValue /= currValue;
        }
        inputValue = ""
        currValue = 0.0;
        displayNumbers();
        lastUsedFunc = "divd"
    }
    
    @IBAction func btn_mltpl(_ sender: Any)
    {
        if savedValue == 0.0
        {
            savedValue = currValue;
        }
        else
        {
            savedValue *= currValue;
        }
        inputValue = ""
        currValue = 0.0;
        displayNumbers();
        lastUsedFunc = "mltpl"
    }
    
    @IBAction func btn_mns(_ sender: Any)
    {
        savedValue -= currValue;
        inputValue = ""
        currValue = 0.0;
        displayNumbers();
        lastUsedFunc = "minus"
    }
    
    @IBAction func btn_add(_ sender: Any)
    {
        savedValue += currValue;
        inputValue = ""
        currValue = 0.0;
        displayNumbers();
        lastUsedFunc = "add"
    }
    
    @IBAction func btn_eql(_ sender: Any)
    {
        if lastUsedFunc == "add"
        {
            savedValue += currValue;
        }
        else if lastUsedFunc == "minus"
        {
            savedValue -= currValue;
        }
        else if lastUsedFunc == "mltpl"
        {
            savedValue *= currValue;
        }
        else if lastUsedFunc == "divd"
        {
            savedValue /= currValue;
        }
        currValue = 0.0;
        lbl_NormalCalcOut.text = String(savedValue);
    }
    
    // to check if there is an amount is saved for the ac c button
    func checkSaved()
    {
        // check to if there is any value in currcalue, if there is, set AC button to be C
        if currValue == 0.0 && savedValue == 0.0
        {
            btn_nrmlAc.configuration?.title = "AC"

        }
        else
        {
            btn_nrmlAc.configuration?.title = "C"
        }
    }
    // convert the string value to double
    func convertToDouble(_ numberString: String, _ variableToAdd:String)
    {
        let numberAsDouble = Double(numberString)
        
        if variableToAdd == "saveValue"
        {
            savedValue = numberAsDouble!;
        }
        else if variableToAdd == "currValue"
        {
            currValue = numberAsDouble!;
        }
    }
    // show the numbers to the label
    func displayNumbers()
    {
        lbl_NormalCalcOut.text = String(currValue);
        checkSaved()
    }
    
    
    
    
    // savings calc functions
    @IBAction func txt_AmntSavedEdit(_ sender: Any)
    {
        if let text = txt_AmntSave.text, let value = Double(text)
        {
            stpr_AmntSaved.value = value
        }
        else
        {
            let alertController = UIAlertController(title: "Invalid Input", message: "Please input a valid number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            stpr_AmntSaved.value = 0.0
            txt_AmntSave.text = ""
        }
        calcSaving()
    }
    
    @IBAction func txt_AmntSavedDone(_ sender: Any)
    {
        if stpr_AmntSaved.value != 0.0
        {
            txt_AmntSave.text = "\(stpr_AmntSaved.value)"
        }
        calcSaving()
    }
    
    @IBAction func stpr_AmntSaved(_ sender: Any)
    {
        if stpr_AmntSaved.value != 0.0
        {
            txt_AmntSave.text = "\(stpr_AmntSaved.value)"
        }
        calcSaving()
    }
    
    

    @IBAction func txt_SalaryEdit(_ sender: Any)
    {
        if let text = txt_Salary.text, let value = Double(text)
        {
            stpr_Salary.value = value
        }
        else
        {
            let alertController = UIAlertController(title: "Invalid Input", message: "Please input a valid number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            stpr_Salary.value = 0.0
            txt_Salary.text = ""
        }
        calcSaving()
    }
    
    @IBAction func txt_SalaryDone(_ sender: Any)
    {
        if stpr_Salary.value != 0.0
        {
            txt_Salary.text = "\(stpr_Salary.value)"
        }
        calcSaving()
    }
    
    @IBAction func stpr_Salary(_ sender: Any)
    {
        if stpr_Salary.value != 0.0
        {
            txt_Salary.text = "\(stpr_Salary.value)"
        }
        calcSaving()
    }
    
    
    
    @IBAction func txt_SalaryCutEdit(_ sender: Any)
    {
        if let text = txt_SalCut.text, let value = Double(text)
        {
            stpr_SalCat.value = value
        }
        else
        {
            let alertController = UIAlertController(title: "Invalid Input", message: "Please input a valid number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            stpr_SalCat.value = 0.0
            txt_SalCut.text = ""
        }
        calcSaving()
    }
    
    @IBAction func txt_SalaryCitDone(_ sender: Any)
    {
        if stpr_SalCat.value != 0.0
        {
            txt_SalCut.text = "\(stpr_SalCat.value) %"
        }
        calcSaving()
    }
    
    @IBAction func stpr_SalaryCut(_ sender: Any)
    {
        if stpr_SalCat.value != 0.0
        {
            txt_SalCut.text = "\(stpr_SalCat.value)"
        }
        calcSaving()
    }
    
    
    @IBAction func stch_SalInc(_ sender: Any)
    {
        if stch_SalInc.isOn
        {
            txt_SalInc.isEnabled = true
            txt_SalInc.text = "\(stpr_SalInc.value)"
            txt_SalInc.backgroundColor = UIColor.quaternaryLabel
            stpr_SalInc.isEnabled = true
        }
        else
        {
            txt_SalInc.isEnabled = false
            txt_SalInc.text = ""
            txt_SalInc.backgroundColor = UIColor.quaternarySystemFill
            stpr_SalInc.isEnabled = false
        }
        calcSaving()
    }
    
    @IBAction func txt_SalIncEdit(_ sender: Any)
    {
        if let text = txt_SalInc.text, let value = Double(text)
        {
            stpr_SalInc.value = value
        }
        else
        {
            let alertController = UIAlertController(title: "Invalid Input", message: "Please input a valid number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            stpr_SalInc.value = 0.0
            txt_SalInc.text = ""
        }
        calcSaving()
    }
    
    @IBAction func txt_SalIncDone(_ sender: Any)
    {
        if stpr_SalInc.value != 0.0
        {
            txt_SalInc.text = "\(stpr_SalInc.value) %"
        }
        calcSaving()
    }
    
    @IBAction func stpr_SalInc(_ sender: Any)
    {
        if stpr_SalInc.value != 0.0
        {
            txt_SalInc.text = "\(stpr_SalInc.value)"
        }
        calcSaving()
    }
    
    
    
    func calcSaving()
    {
        lbl_Period.text = "inf Month"
        
        var period = 0
            
        guard let AmntSave = txt_AmntSave.text, let AmntSaveNum = Double(AmntSave), AmntSaveNum != 0 else { return lbl_Period.text = "Invalid Amount" }
        guard let Salary = txt_Salary.text, let SalaryNum = Double(Salary), SalaryNum != 0 else { return lbl_Period.text = "Invalid Salary" }
        guard let SalCut = txt_SalCut.text, let SalCutNum = Double(SalCut), SalCutNum != 0 else { return lbl_Period.text = "Invalid Salary Cut" }

        
        
        if (stch_SalInc.isOn)
        {
            guard let salInc = txt_SalInc.text, let salIncNum = Double(salInc), salIncNum != 0 else { return lbl_Period.text = "Invalid Salary Increase" }
            
            var salaryI = SalaryNum
            var amountSaved = 0.0
            
            while (amountSaved < AmntSaveNum)
            {
                amountSaved += (salaryI*(SalCutNum/100))
                salaryI += (salaryI*(salIncNum/100))
                period += 1
            }
        }
        else
        {
            period = lround(Double((AmntSaveNum)/(SalaryNum*(SalCutNum/100))))
        }
        
        lbl_Period.text = "\(period) Months"
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        updateTheme()
        
        Record.saveRocrd(mainView!.record)
    }

}
