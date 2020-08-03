//
//  CreateSocialCardViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/2/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit

class CreateSocialCardViewController: UIViewController {
    
    var userName:String = ""
    var instagramUsername:String = ""
    var snapchatUsername:String = ""
    var spotifyUsername:String = ""
    var gmailID:String = ""
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var spotifyTextField: UITextField!
    @IBOutlet weak var snapchatTextField: UITextField!
    @IBOutlet weak var socialsView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.nextButton.layer.cornerRadius = 30
        self.nextButton.layer.borderWidth = 1
        self.nextButton.layer.borderColor = UIColor.black.cgColor
        
        self.welcomeLabel.text = "\(self.userName) you're off to a great start!"
        self.nextButton.isHidden = true
        self.instagramTextField.becomeFirstResponder()
 
    }
   
    @IBAction func instagramReturnDidTapped(_ sender: UITextField) {
        if let instagramUN = instagramTextField.text{
            self.instagramUsername = instagramUN
            self.instagramTextField.resignFirstResponder()
            self.snapchatTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func snapchatReturnDidTapped(_ sender: UITextField) {
        if let snapUN = snapchatTextField.text{
            self.snapchatUsername = snapUN
            self.snapchatTextField.resignFirstResponder()
            self.spotifyTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func spotifyReturnDidTapped(_ sender: UITextField) {
        if let spotifyUN = spotifyTextField.text{
            self.spotifyUsername = spotifyUN
            self.spotifyTextField.resignFirstResponder()
           self.nextButton.isHidden = false
        }
    }
    
    @IBAction func returnDidTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //pass appropriate values to segue destination
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
         segue.destination.modalPresentationStyle = .fullScreen
        
         if let socialCardViewController = segue.destination as? SaveSocialCardViewController{
            if segue.identifier == "createsocial"{
                socialCardViewController.userName = self.userName
                socialCardViewController.instagramUsername = self.instagramUsername
                socialCardViewController.snapchatUsername = self.snapchatUsername
                socialCardViewController.spotifyUsername = self.spotifyUsername
                socialCardViewController.gmailID = self.gmailID
            }
        }
      }
}
