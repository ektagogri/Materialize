//
//  twilioService.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/6/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import Foundation
import Alamofire

class TwilioService{
   static let shared = TwilioService()
    
   private let accountSID:String = "ACa4703f086b600d757d4a65a9ff5d6c0b"
   private let authToken:String = "8a4932d6b384dfad782c2fb60243b3ea"
   private let twilioNumber:String = "+17243906696"
   private let numberToMessage:String = ""
    //send message to detected card user
    func sendMessage(phoneNumber:String) {
        let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
        let parameters = ["From": "\(twilioNumber)", "To": "+16692613312", "Body": "Hello! Let's connect :)"]

        Alamofire.request(url, method: .post, parameters: parameters)
            .authenticate(user: accountSID, password: authToken)
            .responseJSON { response in
              debugPrint(response)
        }
       
    }
}
    

