//
//  BusinessScanViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/6/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MessageUI

 class BusinessScanViewController: UIViewController, ARSCNViewDelegate,ARSessionDelegate,MFMailComposeViewControllerDelegate{

        @IBOutlet var sceneView: ARSCNView!
        
        private let model = BusinessCardsModel.sharedInstance
        private let twilioService = TwilioService.shared
    
        var hitNodeName:String = ""
        var colorCards = ["blue", "yellow", "pink", "orange", "red","indigo","brown", "green"]
        var matchFound:Bool = false
        var shouldPerform:Bool = false

        var configuration = ARImageTrackingConfiguration()
      //  var targetAnchor:ARImageAnchor?
        var session = ARSession()
        var businessCard: BusinessCardAR!
        var selectedCard: BusinessCard!
        let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
               ".serialSceneKitQueue")
           
        override func viewDidLoad() {
            super.viewDidLoad()
            businessCard = BusinessCardAR()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            self.shouldPerform = false
            resetTracking()
            
        }
          
        override func viewWillDisappear(_ animated: Bool) {
              super.viewWillDisappear(animated)
              session.pause()
          }
        
        @IBAction func goBackDidTapped(_ sender: UIBarButtonItem) {
             dismiss(animated: true, completion: nil)
        
        }
    //set AR reference images and start AR session
        func resetTracking() {
          guard let referenceImages =  ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
          configuration.trackingImages = referenceImages
          configuration.maximumNumberOfTrackedImages = 1
          matchFound = false
          sceneView.session = session
          session.delegate = self
          sceneView.delegate = self
          session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        }
//render scene after image is detected
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard let imageAnchor = anchor as? ARImageAnchor else { return }
            let referenceImage = imageAnchor.referenceImage
       
            for card in model.getBusinessCards(){
                let imageName="\(card.getImageName())"
                if matchFound == true {
                         break
                }
                if let matchedBusinessCardName = referenceImage.name, matchedBusinessCardName == imageName{
                    matchFound = true
                    node.addChildNode(businessCard)
                    businessCard.showCard(card: card)
                    selectedCard = card
                }
            }
          }
    //assign tasks based on what node in scene is tapped
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let currentTouchLocation = touches.first?.location(in: self.sceneView),
                  let hitNodeName = self.sceneView.hitTest(currentTouchLocation, options:nil).first?.node.name
            else { return }
            self.hitNodeName = hitNodeName
            self.shouldPerform = false
            
            if hitNodeName == "github" || hitNodeName == "linkedin" || hitNodeName == "website"{
                self.shouldPerform = true
                self.performSegue(withIdentifier: "websiteWebView", sender: nil)
            }
            else if hitNodeName == "phone"{
                self.twilioService.sendMessage(phoneNumber: self.selectedCard.getPhoneNumber())
            }
            else if hitNodeName == "email"{
                if !MFMailComposeViewController.canSendMail() {
                    print("Mail services are not available")
                    return
                }
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = self
                composeVC.setToRecipients([self.selectedCard.getEmailID()])
                composeVC.setSubject("Hello!")
                self.present(composeVC, animated: true, completion: nil)
              //  self.twilioService.sendMessage()
                
            }
        }
    //pass appropriate values to segue destination
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            segue.destination.modalPresentationStyle = .fullScreen
            if let websiteViewController = (segue.destination as? UINavigationController)?.topViewController as? WebsiteViewController{
                    if segue.identifier == "websiteWebView"{
                        if self.hitNodeName == "website"{
                            websiteViewController.websiteURL = self.selectedCard.getWebsiteURL()
                        }
                        else if self.hitNodeName == "linkedin"{
                            websiteViewController.websiteURL =
                           "https://linkedin.com/in/\(self.selectedCard.getLinkedInURL())"
                          
                        }
                        else if self.hitNodeName == "github"{
                            websiteViewController.websiteURL = "https://github.com/\(self.selectedCard.getGitHubUsername())"
                        }
                   }
               }
        }
        override func shouldPerformSegue(withIdentifier:String, sender: Any?) -> Bool {
            return shouldPerform
        }
    
        private func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
            controller.dismiss(animated: true, completion: nil)
        }
        
        func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
             /*  statusViewController.showTrackingQualityInfo(for: camera.trackingState, autoHide: true)
               
               switch camera.trackingState {
               case .notAvailable, .limited:
                   statusViewController.escalateFeedback(for: camera.trackingState, inSeconds: 3.0)
               case .normal:
                   statusViewController.cancelScheduledMessage(for: .trackingStateEscalation)
               } */
           }
           
           func session(_ session: ARSession, didFailWithError error: Error) {
               guard error is ARError else { return }
           }
           
           func sessionWasInterrupted(_ session: ARSession) {
            /*   blurView.isHidden = false
               statusViewController.showMessage("""
               SESSION INTERRUPTED
               The session will be reset after the interruption has ended.
               """, autoHide: false)
        */
           }
           
           func sessionInterruptionEnded(_ session: ARSession) {
             /*  blurView.isHidden = true
               statusViewController.showMessage("RESETTING SESSION")
               
               restartExperience() */
           }
           
           func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
               return true
           }
           
    }

    /*       var customReferenceSet = Set<ARReferenceImage>()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {

            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])

            let filteredContents = directoryContents.filter{ $0.pathExtension == "png" }

            filteredContents.forEach { (url) in

                do{
                    //1. Create A Data Object From Our URL
                    let imageData = try Data(contentsOf: url)
                    guard let image = UIImage(data: imageData) else { return }

                    //2. Convert The UIImage To A CGImage
                    guard let cgImage = image.cgImage else { return }

                    //3. Get The Width Of The Image
                    let imageWidth = CGFloat(cgImage.width)
                    //4. Create A Custom AR Reference Image With A Unique Name
                    let customARReferenceImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: imageWidth)
                    let name = (url.lastPathComponent).components(separatedBy: ".")
                    if let nameURL = name.first{
                    customARReferenceImage.name = "\(nameURL)"}

                    //4. Insert The Reference Image Into Our Set
                    customReferenceSet.insert(customARReferenceImage)

                    print("ARReference Image == \(customARReferenceImage)")

                }catch{

                    print("Error Generating Images == \(error)")

                }

            }

        } catch {

            print("Error Reading Directory Contents == \(error)")

        }
        return customReferenceSet
    } */
    /*    func loadedImagesFromDirectoryContents() -> Set<ARReferenceImage>?{
        var customReferenceSet = Set<ARReferenceImage>()

        for color in colorCards{

            if let image = UIImage(named: color){
                if let cgImage = image.cgImage{
                    let imageWidth = CGFloat(cgImage.width)
                               let customARReferenceImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: imageWidth)
                               customARReferenceImage.name = "\(color)"
                               //4. Insert The Reference Image Into Our Set
                               customReferenceSet.insert(customARReferenceImage)
                }
            }
        }
     
        return customReferenceSet
    }
    */
 
/*    guard let referenceImages = loadedImagesFromDirectoryContents() else {
      fatalError("Missing expected asset catalog resources.")
  } */
