//
//  SaveBusinessCardViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/2/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit
import ARKit

class SaveBusinessCardViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let model = BusinessCardsModel.sharedInstance
    var colorCards = ["blue", "yellow", "pink", "orange", "red","indigo","brown", "green"]
    var userName:String = ""
    var websiteURL:String = ""
    var githubUsername:String = ""
    var linkedInUsername:String = ""
    var phone:String = ""
    var emailAddress:String = ""
    var shouldPerform = false
    var gmailID:String = ""
    
   // @IBOutlet weak var uploadCard: UIButton!
  //  @IBOutlet weak var selectedCard: UIImageView!
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var createCardButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneView.isHidden = true
     //   uploadCard.isHidden = true
        self.phoneNumberTextField.becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.createCardButton.layer.cornerRadius = 30
        self.createCardButton.layer.borderWidth = 1
        self.createCardButton.layer.borderColor = UIColor.black.cgColor
        
     /*   self.uploadCard.backgroundColor = .clear
        self.uploadCard.layer.cornerRadius = 30
        self.uploadCard.layer.borderWidth = 1
        self.uploadCard.layer.borderColor = UIColor.black.cgColor */
        
        self.shouldPerform = false

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
            self.doneView.isHidden = false       }
}

    //assign and save card to user and add business card to model
    @IBAction func createCardTapped(_ sender: UIButton) {
     //   if let imageCard = self.selectedCard.image{
        let count = model.getBusinessCards().count
        let imageName = colorCards[count%8]
        model.insert(name: self.userName,githubUN:self.githubUsername, linkedInUN: self.linkedInUsername, email:self.emailAddress, website: self.websiteURL, phoneNumber:self.websiteURL, image: imageName, gmail: self.gmailID)
   //         }
        if let image = UIImage(named: "\(imageName)Card"){
         UIImageWriteToSavedPhotosAlbum(image, self,#selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }

    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
            performSegue(withIdentifier: "bsave", sender: nil)
            shouldPerform = true
    }
    
    override func shouldPerformSegue(withIdentifier:String, sender: Any?) -> Bool {
       return shouldPerform
    }
    
  /*  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let originalPhoto = info[.originalImage] as! UIImage
        self.selectedCard.image = originalPhoto
        self.doneView.isHidden = false
    } */
    
   /* @IBAction func uploadCardDidTapped(_ sender: UIButton) {
          if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                  let imagePickerController = UIImagePickerController()
                  imagePickerController.sourceType = .photoLibrary
                  imagePickerController.delegate = self
                  present(imagePickerController, animated: true)
              }

      } */
}

 
