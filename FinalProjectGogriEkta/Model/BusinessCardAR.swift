//
//  BusinessCardAR.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/3/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import Foundation
import SceneKit

class BusinessCardAR: SCNNode{
    
    var templateFile:String
    
    //creating variables for all the SCNNodes and elements
    var userNameNode:SCNText
    var businessCardPlane:SCNPlane {didSet {businessCardPlane.name = "businessCardTargetNode"}}
    var emailButtonNode:SCNNode {didSet {emailButtonNode.name = "emailNode"} }
    var websiteButtonNode:SCNNode {didSet {websiteButtonNode.name = "websiteNode"} }
    var githubButtonNode: SCNNode {didSet {githubButtonNode.name = "githubNode"} }
    var linkedInButtonNode:SCNNode {didSet {linkedInButtonNode.name = "linkedinNode"} }
    var phoneButtonNode:SCNNode {didSet{phoneButtonNode.name = "phoneNode"}}
    
    //initialize the nodes with nodes from the scenes
    override init() {
        self.templateFile = "art.scnassets/BusinessCardTemplate.scn"
        
        guard let businessCardRoot = SCNScene(named: self.templateFile)?.rootNode,
     //   let card = template.rootNode.c
        // let businessCardRoot = template.rootNode.childNode(withName: "CardRoot", recursively: false),
        let userName = businessCardRoot.childNode(withName: "userName", recursively: false)?.geometry as? SCNText,
        let businessCard = businessCardRoot.childNode(withName: "businessCardTarget", recursively: false)?.geometry as? SCNPlane,
        let email = businessCardRoot.childNode(withName: "email", recursively: false),
        let website = businessCardRoot.childNode(withName: "website", recursively: false),
        let linkedin = businessCardRoot.childNode(withName: "linkedin", recursively: false),
        let github = businessCardRoot.childNode(withName: "github", recursively: false),
        let phone = businessCardRoot.childNode(withName: "phone", recursively: false)
        
        else {fatalError("Error Getting Business Card Node Data")}
        
        self.userNameNode = userName
        self.businessCardPlane = businessCard
        self.emailButtonNode = email
        self.websiteButtonNode = website
        self.githubButtonNode = github
        self.linkedInButtonNode = linkedin
        self.phoneButtonNode = phone
        
        super.init()
        
        self.addChildNode(businessCardRoot)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeSize(width:CGFloat, height: CGFloat){
        self.businessCardPlane.height = height
        self.businessCardPlane.width = width
    }
    func hideCard(){
        self.userNameNode.string = ""
        self.emailButtonNode.isHidden = true
        self.websiteButtonNode.isHidden = true
        self.githubButtonNode.isHidden = true
        self.linkedInButtonNode.isHidden = true
        self.phoneButtonNode.isHidden = true
        
    }
    
    func showCard(card:BusinessCard){
        self.userNameNode.string = card.getName()
        self.emailButtonNode.isHidden = false
        self.websiteButtonNode.isHidden = false
        self.githubButtonNode.isHidden = false
        self.linkedInButtonNode.isHidden = false
        self.phoneButtonNode.isHidden = false
    }
}
