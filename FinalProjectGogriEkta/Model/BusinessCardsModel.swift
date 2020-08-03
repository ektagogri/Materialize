//
//  BusinessCardsModel.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/1/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import Foundation
import UIKit

class BusinessCardsModel:NSObject{
    
    private var businessCards = [BusinessCard]()
    private var businessCardsFileLocation : URL!
    static let sharedInstance = BusinessCardsModel()
   private var documentsDirectory:URL
    
   override init(){
    
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("doc directory \(documentsDirectory)")
        self.documentsDirectory = documentsDirectory
        businessCardsFileLocation = documentsDirectory.appendingPathComponent("materealizebusinesscards.json")
        super.init()
        if FileManager.default.fileExists(atPath: businessCardsFileLocation.path){
                 load()
             }
    }
    //data persistence
    func load(){
        do{
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: businessCardsFileLocation)
            businessCards = try decoder.decode([BusinessCard].self, from:data)
        }
        catch{}
    }
    //data persistence
    func save(){
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(businessCards)
            let jsonString = String (data: data, encoding: .utf8)!
            try jsonString.write(to: businessCardsFileLocation, atomically: true, encoding: .utf8)
        }
        catch{}
    }
    
    //add card to model
    func insert(name:String, githubUN:String, linkedInUN:String, email:String, website:String, phoneNumber:String, image: String, gmail:String){
        let newBusinessCard = BusinessCard(name: name,githubUN: githubUN, linkedInUN: linkedInUN, email: email, website: website, phoneNumber: phoneNumber, imageName: image, gmail: gmail)
        //let success = self.saveImage(image: image, withName:name)
      //  if success == true {
            self.businessCards.append(newBusinessCard)
            self.save()
      //  }
    }
        
    /*
    func saveImage(image: UIImage, withName: String) -> Bool {
        guard let data = image.pngData()
        else {
            return false
        }
        do {
            let fileName = "\(withName).png"
            try data.write(to:documentsDirectory.appendingPathComponent(fileName))
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    } */
    
    func getBusinessCards()-> [BusinessCard]{
        load()
        return businessCards
    }
    //get cards saved with same email address
    func getSaved(gmailID:String)->[BusinessCard]{
        load()
        var saved = [BusinessCard]()
        for card in businessCards{
            if card.getGmailID() == gmailID{
                saved.append(card)
            }
        }
        return saved
    }
}

