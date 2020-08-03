//
//  SocialCard.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/1/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import Foundation

//struct for social card information
struct SocialCard: Equatable, Codable{
    private var name:String
    //private var facebookUsername:String
    private var instagramUsername:String
    private var snapchatUsername:String
    private var spotifyUsername:String
    private var phoneNumber:String
    private var emailID:String
    private var imageName:String
    private var gmailID:String

    init(name:String,instagramUN:String, snapchatUN:String, spotifyUN:String, phoneNumber:String, email:String, imageName:String, gmail:String){
        self.name = name
     //   self.facebookUsername = facebookUN
        self.instagramUsername = instagramUN
        self.snapchatUsername = snapchatUN
        self.spotifyUsername = spotifyUN
        self.phoneNumber = phoneNumber
        self.emailID = email
        self.imageName = imageName
        self.gmailID = gmail
    }
    
    func getName()->String{
        return name
    }
   /* func getFacebookUsername()->String{
        return facebookUsername
    } */
    
    func getInstagramUsername()->String{
        return self.instagramUsername
    }
    func getSnapchatUsername()->String{
        return self.snapchatUsername
    }
    
    func getSpotifyUsername()->String{
        return self.spotifyUsername
    }
    
    func getPhoneNumber()->String{
        return self.phoneNumber
    }
    
    func getEmail() ->String{
        return self.emailID
    }
    
    func getImageName() ->String{
        return self.imageName
    }
    
    func getGmail()->String{
        return self.gmailID
    }
}

