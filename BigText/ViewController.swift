//
//  ViewController.swift
//  BigText
//
//  Created by Bruno Scheltzke on 14/06/17.
//  Copyright © 2017 Bruno Scheltzke. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    @IBOutlet weak var heightConstraintOfContainerView: NSLayoutConstraint!
    @IBOutlet weak var TextStyleButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bannerViewHolder: UIView!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var DeleteTextButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var bannerView : GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: kGADAdSizeFullBanner)
        bannerViewHolder.addSubview(bannerView)
        bannerView.adUnitID = "ca-app-pub-7119458267348140/4520451092"
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID ]
        bannerView.load(request)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        textView.delegate = self
        textView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        
        
        DeleteTextButton.isHidden = true
        TextStyleButton.isHidden = true
    }
    
    func dismissKeyboard() {
        dismissFontStyleSelection()
        
        if textView.isFirstResponder {
            textView.resignFirstResponder()
            DeleteTextButton.isHidden = true
            TextStyleButton.isHidden = true
        }else{
            textView.becomeFirstResponder()
            DeleteTextButton.isHidden = false
            TextStyleButton.isHidden = false
        }
    }
    
    func keyboardWillShow(notification:NSNotification) {
        dismissFontStyleSelection()
        DeleteTextButton.isHidden = false
        TextStyleButton.isHidden = false
    }
    
    func dismissFontStyleSelection() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4) {
            self.heightConstraintOfContainerView.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func showTextStyleSelection(_ sender: Any) {
        dismissKeyboard()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4) {
            self.heightConstraintOfContainerView.constant = 250
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func deleteText(_ sender: Any) {
        self.label.text = ""
        self.textView.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedSegue"{
            let navController = segue.destination as! UINavigationController
            let viewControllers = navController.viewControllers
            let containerVc = viewControllers.first as! FontStyleViewController
            containerVc.label = self.label
            containerVc.heightConstraintOfContainerView = self.heightConstraintOfContainerView
        }
    }
}

extension ViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.label.text = textView.text
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            self.dismissKeyboard()
            return false
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.textView.textColor = UIColor.clear
        
        if textView.text.isEmpty {
            self.label.text="Go Big Text!!"
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.textView.textColor = self.label.textColor
        return true
    }
}


