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

 class SocialScanViewController: UIViewController, ARSCNViewDelegate,ARSessionDelegate, MFMailComposeViewControllerDelegate{
        
    @IBOutlet weak var sceneView: ARSCNView!
    private let model = SocialCardsModel.sharedInstance
    private let twilioService = TwilioService.shared
   
    var hitNodeName:String = ""
    var colorCards = ["blue", "yellow", "pink", "orange", "red","indigo","brown", "green"]
    var matchFound:Bool = false
    var shouldPerform:Bool = false

    var configuration = ARImageTrackingConfiguration()
      //  var targetAnchor:ARImageAnchor?
    var session = ARSession()
    var socialCard: SocialCardAR!
    var selectedCard: SocialCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socialCard = SocialCardAR()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetTracking()
        model.load()
        self.shouldPerform = false
    }
          
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.pause()
    }
        
    @IBAction func goBackDidTapped(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
    }
    //assign AR reference images and start AR session
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
//render scene if AR reference image is detected
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        
        for card in model.getSocialCards(){
            let imageName="\(card.getImageName())"
            if matchFound == true {
                break
            }
            if let matchedSocialCardName = referenceImage.name, matchedSocialCardName == imageName{
                matchFound = true
                node.addChildNode(socialCard)
                socialCard.showCard(card: card)
                selectedCard = card
            }
        }
    }
    //what to do when nodes from scene are tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currentTouchLocation = touches.first?.location(in: self.sceneView),
        let hitNodeName = self.sceneView.hitTest(currentTouchLocation, options:nil).first?.node.name
        else { return }
        self.hitNodeName = hitNodeName
        self.shouldPerform = false
            
        if hitNodeName == "instagram"{
            if let appURL = URL(string: "instagram://user?username=\(self.selectedCard.getInstagramUsername())"){
                let application = UIApplication.shared
                if application.canOpenURL(appURL) {
                        application.open(appURL)
                }
                else{
                    self.shouldPerform = true
                    self.performSegue(withIdentifier: "socialwebsiteWebView", sender: nil)
                }
            }
        }
        else if hitNodeName == "snapchat"{
             /*   if let appURL = URL(string: "snapchat://add/\(self.selectedCard.getSnapchatUsername())"){
                    let application = UIApplication.shared
                    if application.canOpenURL(appURL) {
                        application.open(appURL)
                    }
                    else{ */
            self.shouldPerform = true
            self.performSegue(withIdentifier: "socialwebsiteWebView", sender: nil)
                   // }
        }
            //}
       else if hitNodeName == "email"{
            if !MFMailComposeViewController.canSendMail() {
                    print("Mail services are not available")
                    return
            }
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([self.selectedCard.getEmail()])
            composeVC.setSubject("Hello!")
            self.present(composeVC, animated: true, completion: nil)
              //  self.twilioService.sendMessage()
        }
       else  if hitNodeName == "phone"{
            self.twilioService.sendMessage(phoneNumber: self.selectedCard.getPhoneNumber())
        }
        else if hitNodeName == "spotify" {
                self.shouldPerform = true
                self.performSegue(withIdentifier: "socialwebsiteWebView", sender: nil)
        }
    
    }
        //pass appropriate values to segue destinatiom
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
        if let websiteViewController = (segue.destination as? UINavigationController)?.topViewController as? WebsiteViewController{
                if segue.identifier == "socialwebsiteWebView"{
                    if self.hitNodeName == "snapchat"{
                        websiteViewController.socialURL = self.selectedCard.getSnapchatUsername()
                        websiteViewController.socialWebsite = "snapchat"
                    }
                    else if self.hitNodeName == "spotify"{
                        websiteViewController.socialURL = self.selectedCard.getSpotifyUsername()
                        websiteViewController.socialWebsite = "spotify"
                    }
                    else if self.hitNodeName == "instagram"{
                        websiteViewController.socialURL = self.selectedCard.getInstagramUsername()
                        websiteViewController.socialWebsite = "instagram"
                    }
                }
            }
    }
        
    override func shouldPerformSegue(withIdentifier:String, sender: Any?) -> Bool {
            return shouldPerform
    }
        
    private func mailComposeController(controller: MFMailComposeViewController,didFinishWithResult result: MFMailComposeResult, error: NSError?){
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
        
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
             /*  statusViewController.showTrackingQualityInfo(for: camera.trackingState, autoHide: true)
               
               switch camera.trackingState {
               case .notAvailable, .limited:
             statusViewConprivate troller.escalateFeedback(for: camera.trackingState, inSeconds: 3.0)
               case .normal:
                   statusViewController.cancelScheduledMessage(for: .trackingStateEscalation)
               } */
    }
           
    func session(_ session: ARSession, didFailWithError error: Error) {
            guard error is ARError else { return }
               
            let errorWithInfo = error as NSError
            let messages = [
                   errorWithInfo.localizedDescription,
                   errorWithInfo.localizedFailureReason,
                   errorWithInfo.localizedRecoverySuggestion
            ]
               // Use `flatMap(_:)` to remove optional error messages.
            DispatchQueue.main.async {
            }
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
