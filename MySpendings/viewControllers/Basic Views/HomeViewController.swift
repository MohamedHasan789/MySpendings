//
//  HomeViewController.swift
//  MySpendings
//
//  Created by Mohamed on 06/01/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var mainView: MainViewController?

    @IBOutlet weak var view_HomeTop: UIView!
    @IBOutlet weak var view_HomeBody: UIView!
    
    
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
    
    
    var fav1 = false
    var fav2 = false
    var fav3 = false
    var fav4 = false
    var fav5 = false
    var fav6 = false
    
    var catgIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = tabBarController as? MainViewController
        // Do any additional setup after loading the view.
        
        
        // call the "fancy" looks function
        pageLook()
        
        initFavs()
        
        refreshPage()
        
    }
    
    
    @IBAction func btn_NextRcrd(_ sender: Any)
    {
        mainView!.goForward()
        refreshPage()
    }
    
    @IBAction func btn_PrevRcrd(_ sender: Any)
    {
        mainView!.goBack()
        refreshPage()
    }
    
    
    func initFavs()
    {
        if mainView!.favs[mainView!.curIndex]!.count >= 1
        {
            fav1 = true
            view_Fav1.backgroundColor = UIColor.white
            icon_Fav1.text = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![0]].icon
            btn_Fav1.configuration?.title = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![0]].name
            
            if (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![0]].alowOverBudgt && (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![0]].getTotal() >= mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![0]].budget ?? 0))
            {
                wrn_Fav1.isHidden = false
            }
        }
        
        if mainView!.favs[mainView!.curIndex]!.count >= 2
        {
            fav2 = true
            view_Fav2.backgroundColor = UIColor.white
            icon_Fav2.text = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![1]].icon
            btn_Fav2.configuration?.title = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![1]].name
            
            if (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![1]].alowOverBudgt && (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![1]].getTotal() >= mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![1]].budget ?? 0))
            {
                wrn_Fav2.isHidden = false
            }
        }
        
        if mainView!.favs[mainView!.curIndex]!.count >= 3
        {
            fav3 = true
            view_Fav3.backgroundColor = UIColor.white
            icon_Fav3.text = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![2]].icon
            btn_Fav3.configuration?.title = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![2]].name
            
            if (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![2]].alowOverBudgt && (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![2]].getTotal() >= mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![2]].budget ?? 0))
            {
                wrn_Fav3.isHidden = false
            }
        }
        
        if mainView!.favs[mainView!.curIndex]!.count >= 4
        {
            fav4 = true
            view_Fav4.backgroundColor = UIColor.white
            icon_Fav4.text = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![3]].icon
            btn_Fav4.configuration?.title = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![3]].name
            
            if (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![3]].alowOverBudgt && (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![3]].getTotal() >= mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![3]].budget ?? 0))
            {
                wrn_Fav4.isHidden = false
            }
        }
        
        if mainView!.favs[mainView!.curIndex]!.count >= 5
        {
            fav5 = true
            view_Fav5.backgroundColor = UIColor.white
            icon_Fav5.text = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![4]].icon
            btn_Fav5.configuration?.title = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![4]].name
            
            if (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![4]].alowOverBudgt && (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![4]].getTotal() >= mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![4]].budget ?? 0))
            {
                wrn_Fav5.isHidden = false
            }
        }
        
        if mainView!.favs[mainView!.curIndex]!.count == 6
        {
            fav6 = true
            view_Fav6.backgroundColor = UIColor.white
            icon_Fav6.text = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![5]].icon
            btn_Fav6.configuration?.title = mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![5]].name
            
            if (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![5]].alowOverBudgt && (mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![5]].getTotal() >= mainView!.records[mainView!.currRcrd]![mainView!.favs[mainView!.currIndex]![5]].budget ?? 0))
            {
                wrn_Fav6.isHidden = false
            }
        }
    }
    
    @IBAction func btn_1Fav(_ sender: Any)
    {
        if fav1
        {
            catgIndex = mainView!.favs[mainView!.currIndex]![0]
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
            catgIndex = mainView!.favs[mainView!.currIndex]![1]
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
            catgIndex = mainView!.favs[mainView!.currIndex]![2]
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
            catgIndex = mainView!.favs[mainView!.currIndex]![3]
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
            catgIndex = mainView!.favs[mainView!.currIndex]![4]
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
            catgIndex = mainView!.favs[mainView!.currIndex]![5]
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "quickItem")
        {
            let itemsView = segue.destination as! ItemsViewController
            itemsView.catgIndex = catgIndex
        }
    }
    
    
    
    func pageLook() // to have the fancy look of the application
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

    
    func updateTheme()
    {
        view_HomeBody.backgroundColor = mainView!.mianColor
        view_HomeTop.backgroundColor = mainView!.scndColor
    }
    
    func refreshPage()
    {
        mainView = tabBarController as? MainViewController
        
        if (mainView!.hasNext)
        {
            btn_NextRcrd.isEnabled = true
        }
        else
        {
            btn_NextRcrd.isEnabled = false
        }
        
        if (mainView!.hasBefore)
        {
            btn_PrevRcrd.isEnabled = true
        }
        else
        {
            btn_PrevRcrd.isEnabled = false
        }
        
        lbl_RcrdTotal.text = mainView?.currRcrd
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTheme()
        initFavs()
    }
}
