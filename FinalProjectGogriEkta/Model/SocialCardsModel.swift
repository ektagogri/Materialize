//
//  SocialCardsModel.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/1/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import Foundation

class SocialCardsModel:NSObject{
    
    private var socialCards = [SocialCard]()
    private var socialCardsFileLocation : URL!
    static let sharedInstance = SocialCardsModel()
    
   override init(){
     
        super.init()
             
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("doc directory \(documentsDirectory)")
        socialCardsFileLocation = documentsDirectory.appendingPathComponent("materealizesocialcards.json")

        if FileManager.default.fileExists(atPath: socialCardsFileLocation.path){
                 load()
             }
    }
    //data persistence
    func load(){
        do{
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: socialCardsFileLocation)
            socialCards = try decoder.decode([SocialCard].self, from:data)
        }
        catch{}
    }
    //data persistence
    func save(){
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(socialCards)
            let jsonString = String (data: data, encoding: .utf8)!
            try jsonString.write(to: socialCardsFileLocation, atomically: true, encoding: .utf8)
        }
        catch{}
    }
    //add card to model
    func insert(name:String, instagramUN:String, snapchatUN:String, spotifyUN:String, phone:String, email:String, imageName:String, gmail:String){
        let newSocialCard = SocialCard(name: name,instagramUN: instagramUN, snapchatUN: snapchatUN, spotifyUN:spotifyUN, phoneNumber: phone,email:email, imageName: imageName, gmail: gmail)
        socialCards.append(newSocialCard)
        save()
      }
    
    func getSocialCards()-> [SocialCard]{
        load()
        return socialCards
    }
    //get cards saved with the email address
    func getSaved(gmailID:String)->[SocialCard]{
        load()
        var saved = [SocialCard]()
        for card in socialCards{
            if card.getGmail() == gmailID{
                saved.append(card)
            }
        }
        return saved
    }
    
}

