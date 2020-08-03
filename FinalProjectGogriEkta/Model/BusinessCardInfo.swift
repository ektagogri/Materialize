//
//  BusinessCard.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/1/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import Foundation
import UIKit
//struct for business card info
struct BusinessCard: Equatable, Codable{
    private var name:String
    private var githubUsername:String
    private var linkedInUsername:String
    private var emailID:String
    private var websiteURL:String
    private var phoneNumber:String
    private var imageName:String
    private var gmailID:String
   
    init(name:String, githubUN:String, linkedInUN:String, email:String, website:String, phoneNumber:String, imageName:String, gmail:String){
        self.name = name
        self.githubUsername = githubUN
        self.linkedInUsername = linkedInUN
        self.emailID = email
        self.websiteURL = website
        self.phoneNumber = phoneNumber
        self.imageName = imageName
        self.gmailID = gmail
    }
    
    func getName()->String{
        return name
    }
    
    func getGitHubUsername()->String{
        return githubUsername
    }
    
    func getLinkedInURL()->String{
        return linkedInUsername
    }
    func getEmailID()->String{
        return emailID
    }
    
    func getWebsiteURL()->String{
        return websiteURL
    }
    
    func getPhoneNumber()->String{
        return phoneNumber
    }
    
    func getImageName()->String{
        return imageName
    }
    func getGmailID()->String{
        return gmailID
    }
}

