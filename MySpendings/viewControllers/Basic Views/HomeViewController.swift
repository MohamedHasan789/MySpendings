//
//  HomeViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

// **PLEASE NOTE** //
// as that "mainView" is the tabbar controller and will always be present no matter which view the user is in, it will be force unrapwd for the entirity if the application, this is done to nigate the extra "14251" lines of code requiried for each entry of the "mainView!"
// **PLEASE NOTE** //

import UIKit

class HomeViewController: UIViewController {
    
    var mainView: MainViewController?
    
    // oulets of the view
    @IBOutlet weak var view_HomeTop: UIView!
    @IBOutlet weak var view_HomeBody: UIView!
    
    
    @IBOutlet weak var lbl_CurrRcrd: UILabel!
    @IBOutlet weak var lbl_RcrdTotal: UILabel!
    
    @IBOutlet weak var btn_NextRcrd: UIButton!
    @IBOutlet weak var btn_PrevRcrd: UIButton!
    
    
    @IBOutlet weak var view_Fav1: UIView!
    @IBOutlet weak var icon_Fav1: UILabel!
    @IBOutlet weak var btn_Fav1: UIButton!
    @IBOutlet weak var wrn_Fav1: UIView!
    
    @IBOutlet weak var view_Fav2: UIView!
    @IBOutlet weak var icon_Fav2: UILabel!
    @IBOutlet weak var btn_Fav2: UIButton!
    @IBOutlet weak var wrn_Fav2: UIView!
    
    @IBOutlet weak var view_Fav3: UIView!
    @IBOutlet weak var icon_Fav3: UILabel!
    @IBOutlet weak var btn_Fav3: UIButton!
    @IBOutlet weak var wrn_Fav3: UIView!
    
    @IBOutlet weak var view_Fav4: UIView!
    @IBOutlet weak var icon_Fav4: UILabel!
    @IBOutlet weak var btn_Fav4: UIButton!
    @IBOutlet weak var wrn_Fav4: UIView!
    
    @IBOutlet weak var view_Fav5: UIView!
    @IBOutlet weak var icon_Fav5: UILabel!
    @IBOutlet weak var btn_Fav5: UIButton!
    @IBOutlet weak var wrn_Fav5: UIView!
    
    @IBOutlet weak var view_Fav6: UIView!
    @IBOutlet weak var icon_Fav6: UILabel!
    @IBOutlet weak var btn_Fav6: UIButton!
    @IBOutlet weak var wrn_Fav6: UIView!
    
    // booleans (to check if there is a fav for each button - extra)
    var fav1 = false
    var fav2 = false
    var fav3 = false
    var fav4 = false
    var fav5 = false
    var fav6 = false
    
    // to send to the view items view (quick acc - extra)
    var catgIndex: Int?
    
    var tmpCatDisable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = tabBarController as? MainViewController
        // Do any additional setup after loading the view.
        
        
        // call the "fancy" looks function
        pageLook()
        
        initFavs()
        
        refreshPage()
        
    }
    
    
    // methods to move records (prev/next month) - linked to main page
    @IBAction func btn_NextRcrd(_ sender: Any)
    {
        if let mainView = mainView {
            mainView.goForward()
        }
        refreshPage()
    }
    
    @IBAction func btn_PrevRcrd(_ sender: Any)
    {
        if let mainView = mainView {
            mainView.goBack()
        }
        refreshPage()
    }
    
    // method to get the fav catgs for this record
    func initFavs()
    {
        // set all items to false first (when updating)
        fav1 = false
        fav2 = false
        fav3 = false
        fav4 = false
        fav5 = false
        fav6 = false
        
        view_Fav1.backgroundColor = UIColor.quaternaryLabel
        view_Fav2.backgroundColor = UIColor.quaternaryLabel
        view_Fav3.backgroundColor = UIColor.quaternaryLabel
        view_Fav4.backgroundColor = UIColor.quaternaryLabel
        view_Fav5.backgroundColor = UIColor.quaternaryLabel
        view_Fav6.backgroundColor = UIColor.quaternaryLabel
        
        icon_Fav1.text = "+"
        icon_Fav2.text = "+"
        icon_Fav3.text = "+"
        icon_Fav4.text = "+"
        icon_Fav5.text = "+"
        icon_Fav5.text = "+"
        
        btn_Fav1.configuration?.title = "Add"
        btn_Fav2.configuration?.title = "Add"
        btn_Fav3.configuration?.title = "Add"
        btn_Fav4.configuration?.title = "Add"
        btn_Fav5.configuration?.title = "Add"
        btn_Fav6.configuration?.title = "Add"
        
        wrn_Fav1.isHidden = true
        wrn_Fav2.isHidden = true
        wrn_Fav3.isHidden = true
        wrn_Fav4.isHidden = true
        wrn_Fav5.isHidden = true
        wrn_Fav6.isHidden = true
        
        
        if mainView!.record.favs[mainView!.record.currIndex]!.count >= 1
        {
            fav1 = true
            view_Fav1.backgroundColor = mainView!.itemsColor
            icon_Fav1.text = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![0]].icon
            btn_Fav1.configuration?.title = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![0]].name
            
            if (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![0]].alowOverBudgt && (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![0]].getTotal() >= mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![0]].budget ?? 0))
            {
                wrn_Fav1.isHidden = false
            }
        }
        
        if mainView!.record.favs[mainView!.record.currIndex]!.count >= 2
        {
            fav2 = true
            view_Fav2.backgroundColor = mainView!.itemsColor
            icon_Fav2.text = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![1]].icon
            btn_Fav2.configuration?.title = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![1]].name
            
            if (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![1]].alowOverBudgt && (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![1]].getTotal() >= mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![1]].budget ?? 0))
            {
                wrn_Fav2.isHidden = false
            }
        }
        
        if mainView!.record.favs[mainView!.record.currIndex]!.count >= 3
        {
            fav3 = true
            view_Fav3.backgroundColor = mainView!.itemsColor
            icon_Fav3.text = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![2]].icon
            btn_Fav3.configuration?.title = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![2]].name
            
            if (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![2]].alowOverBudgt && (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![2]].getTotal() >= mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![2]].budget ?? 0))
            {
                wrn_Fav3.isHidden = false
            }
        }
        
        if mainView!.record.favs[mainView!.record.currIndex]!.count >= 4
        {
            fav4 = true
            view_Fav4.backgroundColor = mainView!.itemsColor
            icon_Fav4.text = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![3]].icon
            btn_Fav4.configuration?.title = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![3]].name
            
            if (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![3]].alowOverBudgt && (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![3]].getTotal() >= mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![3]].budget ?? 0))
            {
                wrn_Fav4.isHidden = false
            }
        }
        
        if mainView!.record.favs[mainView!.record.currIndex]!.count >= 5
        {
            fav5 = true
            view_Fav5.backgroundColor = mainView!.itemsColor
            icon_Fav5.text = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![4]].icon
            btn_Fav5.configuration?.title = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![4]].name
            
            if (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![4]].alowOverBudgt && (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![4]].getTotal() >= mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![4]].budget ?? 0))
            {
                wrn_Fav5.isHidden = false
            }
        }
        
        if mainView!.record.favs[mainView!.record.currIndex]!.count == 6
        {
            fav6 = true
            view_Fav6.backgroundColor = mainView!.itemsColor
            icon_Fav6.text = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![5]].icon
            btn_Fav6.configuration?.title = mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![5]].name
            
            if (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![5]].alowOverBudgt && (mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![5]].getTotal() >= mainView!.record.records[mainView!.record.currRcrd]![mainView!.record.favs[mainView!.record.currIndex]![5]].budget ?? 0))
            {
                wrn_Fav6.isHidden = false
            }
        }
    }
    
    // btn actions for each fav menu - extra
    @IBAction func btn_1Fav(_ sender: Any)
    {
        if fav1
        {
            catgIndex = mainView!.record.favs[mainView!.record.currIndex]![0]
            performSegue(withIdentifier: "quickItem", sender: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Add a new category", message: "Please create a new category and select it as a favourite", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_2Fav(_ sender: Any)
    {
        if fav2
        {
            catgIndex = mainView!.record.favs[mainView!.record.currIndex]![1]
            performSegue(withIdentifier: "quickItem", sender: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Add a new category", message: "Please create a new category and select it as a favourite", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_3Fav(_ sender: Any)
    {
        if fav3
        {
            catgIndex = mainView!.record.favs[mainView!.record.currIndex]![2]
            performSegue(withIdentifier: "quickItem", sender: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Add a new category", message: "Please create a new category and select it as a favourite", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_4Fav(_ sender: Any)
    {
        if fav4
        {
            catgIndex = mainView!.record.favs[mainView!.record.currIndex]![3]
            performSegue(withIdentifier: "quickItem", sender: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Add a new category", message: "Please create a new category and select it as a favourite", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_5Fav(_ sender: Any)
    {
        if fav5
        {
            catgIndex = mainView!.record.favs[mainView!.record.currIndex]![4]
            performSegue(withIdentifier: "quickItem", sender: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Add a new category", message: "Please create a new category and select it as a favourite", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_6Fav(_ sender: Any)
    {
        if fav6
        {
            catgIndex = mainView!.record.favs[mainView!.record.currIndex]![5]
            performSegue(withIdentifier: "quickItem", sender: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Add a new category", message: "Please create a new category and select it as a favourite", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // get the index of the catgory before doing segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "quickItem")
        {
            if (mainView!.record.catgChanged)
            {
                mainView!.record.catgChanged = false
                tmpCatDisable = true
            }
            let itemsView = segue.destination as! ItemsViewController
            itemsView.catgIndex = catgIndex
        }
    }
    
    
    // to have the fancy look of the application
    func pageLook()
    {
        view_HomeTop.layer.cornerRadius = 45
        view_HomeTop.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        view_HomeBody.layer.shadowColor = UIColor.black.cgColor
        view_HomeBody.layer.shadowOpacity = 0.3
        view_HomeBody.layer.shadowRadius = 5
        
        view_HomeTop.layer.shadowColor = UIColor.black.cgColor
        view_HomeTop.layer.shadowOpacity = 0.18
        view_HomeTop.layer.shadowRadius = 10
        view_HomeTop.layer.shadowOffset = CGSize(width: 0, height: -10)
        
        view_HomeBody.layer.shouldRasterize = true
        view_HomeBody.layer.shouldRasterize = true
        
        updateTheme()
    }

    // update the colors of the page
    func updateTheme()
    {
        view_HomeBody.backgroundColor = mainView!.mianColor
        view_HomeTop.backgroundColor = mainView!.scndColor
    }
    
    // refresh the data (move btns/ amount/ theme)
    func refreshPage()
    {
        mainView = tabBarController as? MainViewController
        
        if (mainView!.record.hasNext)
        {
            btn_NextRcrd.isEnabled = true
        }
        else
        {
            btn_NextRcrd.isEnabled = false
        }
        
        if (mainView!.record.hasBefore)
        {
            btn_PrevRcrd.isEnabled = true
        }
        else
        {
            btn_PrevRcrd.isEnabled = false
        }
        
        let totalRcrd = mainView?.record.getTotal()
        let carncRcrd = mainView?.record.currncy
        lbl_RcrdTotal.text = "\(totalRcrd!) \(carncRcrd!)"
        lbl_CurrRcrd.text = mainView?.record.currRcrd
        initFavs()
        updateTheme()
        
    }
    
    // call the refresh methods whenever the page is loaded
    override func viewWillAppear(_ animated: Bool) {
        
        refreshPage()
        
        if tmpCatDisable
        {
            mainView!.record.catgChanged = true
            tmpCatDisable = false
        }
        
        Record.saveRocrd(mainView!.record)
    }
    
}
