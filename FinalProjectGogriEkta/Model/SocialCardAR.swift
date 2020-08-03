//
//  BusinessCardAR.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/3/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import Foundation
import SceneKit

class SocialCardAR: SCNNode{
    
    var templateFile:String
    
    //creating variables for all the SCNNodes and elements
    var userNameNode:SCNText
    var socialCardPlane:SCNPlane {didSet {socialCardPlane.name = "socialCardTargetNode"}}
    var emailButtonNode:SCNNode {didSet {emailButtonNode.name = "emailNode"} }
    var snapchatButtonNode:SCNNode {didSet {snapchatButtonNode.name = "snapchatNode"} }
    var spotifyButtonNode: SCNNode {didSet {spotifyButtonNode.name = "spotifyNode"} }
    var instagramButtonNode:SCNNode {didSet {instagramButtonNode.name = "instagramnNode"} }
     var phoneButtonNode:SCNNode {didSet{phoneButtonNode.name = "phoneNode"}}
    
    //initialize the nodes with nodes from the scenes
    override init() {
        self.templateFile = "art.scnassets/SocialCardTemplate.scn"
        
        guard let socialCardRoot = SCNScene(named: self.templateFile)?.rootNode,
     //   let card = template.rootNode.c
        // let businessCardRoot = template.rootNode.childNode(withName: "CardRoot", recursively: false),
        let userName = socialCardRoot.childNode(withName: "userName", recursively: false)?.geometry as? SCNText,
        let socialCard = socialCardRoot.childNode(withName: "socialCardTarget", recursively: false)?.geometry as? SCNPlane,
        let email = socialCardRoot.childNode(withName: "email", recursively: false),
        let snapchat = socialCardRoot.childNode(withName: "snapchat", recursively: false),
        let spotify = socialCardRoot.childNode(withName: "spotify", recursively: false),
        let instagram = socialCardRoot.childNode(withName: "instagram", recursively: false),
        let phone = socialCardRoot.childNode(withName: "phone", recursively: false)
        
        else {fatalError("Error Getting Business Card Node Data")}
        
        self.userNameNode = userName
        self.socialCardPlane = socialCard
        self.emailButtonNode = email
        self.snapchatButtonNode = snapchat
        self.instagramButtonNode = instagram
        self.spotifyButtonNode = spotify
        self.phoneButtonNode = phone
        
        super.init()
        
        self.addChildNode(socialCardRoot)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 //toggle visibility
    func hideCard(){
        self.userNameNode.string = ""
        self.emailButtonNode.isHidden = true
        self.snapchatButtonNode.isHidden = true
        self.instagramButtonNode.isHidden = true
        self.spotifyButtonNode.isHidden = true
        self.phoneButtonNode.isHidden = true
        
    }
    
    func showCard(card:SocialCard){
        self.userNameNode.string = card.getName()
        self.emailButtonNode.isHidden = false
        self.snapchatButtonNode.isHidden = false
        self.instagramButtonNode.isHidden = false
        self.spotifyButtonNode.isHidden = false
        self.phoneButtonNode.isHidden = false
    }
}
