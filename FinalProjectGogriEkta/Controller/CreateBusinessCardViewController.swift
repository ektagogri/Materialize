//
//  CreateBusinessCardViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/2/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit

class CreateBusinessCardViewController: UIViewController {
    
    var userName:String = ""
    var websiteURL:String = ""
    var githubUsername:String = ""
    var linkedInUsername:String = ""
    var gmailID:String = ""
    
    @IBOutlet weak var linksView: UIView!
    
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var linkedInTextField: UITextField!
    @IBOutlet weak var githubTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
          self.welcomeLabel.text = "\t\(self.userName) you're off to a great start!"
        super.viewWillAppear(true)
        self.nextButton.isHidden = true
        self.nextButton.layer.cornerRadius = 30
        self.nextButton.layer.borderWidth = 1
        self.nextButton.layer.borderColor = UIColor.black.cgColor
        self.websiteTextField.becomeFirstResponder()
       }
    
    @IBAction func websiteReturnDidTapped(_ sender: UITextField) {
        if let website = websiteTextField.text{
            self.websiteURL = website
            self.websiteTextField.resignFirstResponder()
            self.linkedInTextField.becomeFirstResponder()
        }
    }
    @IBAction func linkedInReturnDidTapped(_ sender: UITextField) {
        if let linkedIN = linkedInTextField.text{
            self.linkedInUsername = linkedIN
            self.linkedInTextField.resignFirstResponder()
            self.githubTextField.becomeFirstResponder()
        }
    }
    @IBAction func githubReturnDidTapped(_ sender: UITextField) {
        if let github = githubTextField.text{
             self.githubUsername = github
            self.githubTextField.resignFirstResponder()
            self.nextButton.isHidden = false
         }
    }
    @IBAction func backDidTapped(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
    }
       
    //pass appropriate values to segue destination
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
         segue.destination.modalPresentationStyle = .fullScreen
        
         if let businessCardViewController = segue.destination as? SaveBusinessCardViewController{
            if segue.identifier == "createbusiness"{
                businessCardViewController.userName = self.userName
                businessCardViewController.websiteURL = self.websiteURL
                businessCardViewController.githubUsername = self.githubUsername
                businessCardViewController.linkedInUsername = self.linkedInUsername
                businessCardViewController.gmailID = self.gmailID
            }
        }
      }
}
