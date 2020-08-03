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
   
   //values removed
   private let accountSID:String = ""
   private let authToken:String = ""
   private let twilioNumber:String = ""
   private let numberToMessage:String = ""
    //send message to detected card user
    func sendMessage(phoneNumber:String) {
        let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
        let parameters = ["From": "\(twilioNumber)", "To": "", "Body": "Hello! Let's connect :)"]

        Alamofire.request(url, method: .post, parameters: parameters)
            .authenticate(user: accountSID, password: authToken)
            .responseJSON { response in
              debugPrint(response)
        }
       
    }
}
    

