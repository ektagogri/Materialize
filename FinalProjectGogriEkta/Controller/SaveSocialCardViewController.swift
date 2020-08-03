//
//  SaveSocialCardViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/2/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit

class SaveSocialCardViewController: UIViewController {

    private let model = SocialCardsModel.sharedInstance
    var colorCards = ["blue", "yellow", "pink", "orange", "red","indigo","brown", "green"]
    
    var userName:String = ""
    var instagramUsername:String = ""
    var snapchatUsername:String = ""
    var spotifyUsername:String = ""
    var phone:String = ""
    var emailAddress:String = ""
    var shouldPerform = false
    var gmailID:String = ""
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var createCardButton: UIButton!
    
    @IBOutlet weak var submitView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitView.isHidden = true
        self.phoneNumberTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.createCardButton.layer.cornerRadius = 30
        self.createCardButton.layer.borderWidth = 1
        self.createCardButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func phoneReturnDidTapped(_ sender: UITextField) {
        if let phoneNum = phoneNumberTextField.text{
               self.phone = phoneNum
               self.phoneNumberTextField.resignFirstResponder()
                self.emailTextField.becomeFirstResponder()
           }
    }
    
    
    @IBAction func emailReturnDidTapped(_ sender: UITextField) {
        if let email = emailTextField.text{
            self.emailAddress = email
            self.emailTextField.resignFirstResponder()
                     //   self.uploadCard.isHidden = false
            self.submitView.isHidden = false
        }
    }
    //assign and save social card to user and insert card to model
    @IBAction func createCardDidTapped(_ sender: UIButton) {
        let count = model.getSocialCards().count
        let imageName = colorCards[count%8]
        
        model.insert(name: self.userName, instagramUN: self.instagramUsername, snapchatUN: self.snapchatUsername, spotifyUN: self.spotifyUsername, phone: self.phone, email: self.emailAddress, imageName: imageName, gmail:self.gmailID)
        
        if let image = UIImage(named: "\(imageName)Card"){
                UIImageWriteToSavedPhotosAlbum(image, self,#selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
               }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
            performSegue(withIdentifier: "ssave", sender: nil)
            shouldPerform = true
    }
    
    override func shouldPerformSegue(withIdentifier:String, sender: Any?) -> Bool {
       return shouldPerform
    }
    
    
}


