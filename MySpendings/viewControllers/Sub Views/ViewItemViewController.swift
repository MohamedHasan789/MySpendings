//
//  ViewItemViewController.swift
//  MySpendings
//
//  Created by Mohamed on 13/01/2023.
//

import UIKit

class ViewItemViewController: UIViewController, UIScrollViewDelegate {

    var retrivedItem: Item?
    var mainColor: UIColor?
    
    @IBOutlet var view_MainBody: UIView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var txt_Icon: UITextField!
    @IBOutlet weak var txt_Price: UITextField!
    @IBOutlet weak var txt_Amount: UITextField!
    @IBOutlet weak var txt_Total: UITextField!
    @IBOutlet weak var dat_Date: UIDatePicker!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var viw_ImagePlace: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getItem()
        
        setUpScrollView()
        
        updateTheme()
    }
    
    // update the colors of the page
    func updateTheme()
    {
        view_MainBody.backgroundColor = mainColor!
    }
    
    // get the proprties of the object and populate the view
    func getItem()
    {
        lbl_Name.text = retrivedItem!.name
        txt_Icon.text = retrivedItem!.icon
        txt_Price.text = "\(retrivedItem!.price)"
        txt_Amount.text = "\(retrivedItem!.amount)"
        txt_Total.text = "\(retrivedItem!.getPrice())"
        dat_Date.date = retrivedItem!.dateTime
        
        if let imagedata = retrivedItem?.rcptImage
        {
            imgView.image = UIImage(data: imagedata)
        }
    }
    
    // zzoming functions
    // setup scrollview sizing
    func setUpScrollView()
    {
        scrollView.delegate = self
    }
    
    // allow zooming for imageview
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    
    // chnage the zoom values based on scroll value
    func updateZoomFor(size: CGSize)
    {
        let widthScale = size.width / imgView.bounds.width
        let heighScale = size.height / imgView.bounds.height
        let scale = min(widthScale,heighScale)
        scrollView.minimumZoomScale = scale
        scrollView.zoomScale = scale
    }
    
    // call the refresh methods whenever the page is loaded
    override func viewWillAppear(_ animated: Bool) {
        updateZoomFor(size: view.bounds.size)
    }
}
