//
//  CardGeneratorViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/1/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit
import GoogleSignIn

class CardGeneratorViewController: UIViewController,GIDSignInDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var choiceLabel: UILabel!
    
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var choiceView: UIView!
    @IBOutlet weak var createSocialCard: UIButton!
    @IBOutlet weak var createBusinessCard: UIButton!
    
    @IBOutlet weak var viewBusinessCards: UIButton!
    @IBOutlet weak var viewSavedCards: UIButton!
    private var userName:String=""
    private var email:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
          
        super.viewWillAppear(true)
        
        self.createSocialCard.backgroundColor = .white
        self.createSocialCard.layer.cornerRadius = 30
        self.createSocialCard.layer.borderWidth = 1
        self.createSocialCard.layer.borderColor = UIColor.black.cgColor
        
        self.createBusinessCard.backgroundColor = .white
        self.createBusinessCard.layer.cornerRadius = 30
        self.createBusinessCard.layer.borderWidth = 1
        self.createBusinessCard.layer.borderColor = UIColor.black.cgColor
        
        self.viewBusinessCards.layer.cornerRadius = 30
        self.viewBusinessCards.layer.borderWidth = 1
        self.viewBusinessCards.layer.borderColor = UIColor.black.cgColor
        
        self.viewSavedCards.layer.cornerRadius = 30
        self.viewSavedCards.layer.borderWidth = 1
        self.viewSavedCards.layer.borderColor = UIColor.black.cgColor
        
        self.nameLabel.isHidden = true
        self.nameTextField.isHidden = true
        self.nameTextField.text = ""
        self.choiceLabel.isHidden = true
        self.createBusinessCard.isHidden = true
        self.createSocialCard.isHidden = true
        self.choiceView.isHidden = true
      }
    
    @IBAction func signIn(_ sender: GIDSignInButton) {
           GIDSignIn.sharedInstance()?.signIn()
       }
    //sign in user using google sign in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
               withError error: Error!) {
       if let error = error {
         if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
           print("The user has not signed in before or they have since signed out.")
         } else {
           print("\(error.localizedDescription)")
         }
         return
       }
   
      if  let email = user.profile.email{
        self.email = email
        self.nameLabel.isHidden = false
        self.nameTextField.isHidden = false
        self.nameTextField.becomeFirstResponder()
     }
   
         // Perform any operations on signed in user here.
           // let userId = user.userID                  // For client-side use only!
          //  let idToken = user.authentication.idToken // Safe to send to the server
           //   if let fullName = user.profile.name{
           //      print(fullName)

           //   }
          //  let givenName = user.profile.givenName
        //    let familyName = user.profile.familyName
     
     }
     
    @IBAction func returnDidTapped(_ sender: UITextField) {
        self.nameTextField.resignFirstResponder()
            if let userName = nameTextField.text{
                self.userName = userName
                self.choiceLabel.text = "\t W E L C O M E\t \(userName.capitalized)!\n\twhat would you like to do today?"
                self.choiceView.isHidden = false
                self.choiceLabel.isHidden = false
                self.createBusinessCard.isHidden = false
                self.createSocialCard.isHidden = false
            }
    }
    
    @IBAction func createSocial(_ sender: UIButton) {
        self.createSocialCard.layer.borderColor = UIColor.green.cgColor
    }
    
    
    @IBAction func createBusiness(_ sender: UIButton) {
        self.createBusinessCard.layer.borderColor = UIColor.green.cgColor
    }
    
    //pass appropriate values to segue destination
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         segue.destination.modalPresentationStyle = .fullScreen
        
        if let socialCardViewController = (segue.destination as? UINavigationController)?.topViewController as? CreateSocialCardViewController{
            if segue.identifier == "social"{
                socialCardViewController.userName = self.userName
                socialCardViewController.gmailID = self.email
            }
        }
         if let businessCardViewController = (segue.destination as? UINavigationController)?.topViewController as? CreateBusinessCardViewController{
            if segue.identifier == "business"{
                businessCardViewController.userName = self.userName
                businessCardViewController.gmailID = self.email
            }
        }
        if let savedCardViewController = (segue.destination as? UINavigationController)?.topViewController as? SavedTableViewController{
             if segue.identifier == "savedscards"{
                savedCardViewController.mode = "Social"
                savedCardViewController.gmailID = self.email
             }
            if segue.identifier == "savedbcards"{
               savedCardViewController.mode = "Business"
                savedCardViewController.gmailID = self.email
            }
         }
      }

}
