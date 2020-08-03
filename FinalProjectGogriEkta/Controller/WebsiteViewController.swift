//
//  WebsiteViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/3/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit
import WebKit

class WebsiteViewController: UIViewController {

    @IBOutlet weak var websiteWebView: WKWebView!
    var websiteURL:String?
    var socialURL:String?
    var socialWebsite:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //open appropriate links
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let websitelink = self.websiteURL{
             if let myURL = URL(string: websitelink){
                 let myRequest = URLRequest(url: myURL)
                 websiteWebView.load(myRequest)
             }
         }
         
         if let username = self.socialURL, let social = self.socialWebsite{
             if social == "snapchat"{
                 if let myURL = URL(string: "https://www.snapchat.com/add/\(username)"){
                     let myRequest = URLRequest(url: myURL)
                     websiteWebView.load(myRequest)
                 }
             }
             else if social == "instagram"{
                 if let myURL = URL(string: "https://instagram.com/\(username)"){
                     let myRequest = URLRequest(url: myURL)
                     websiteWebView.load(myRequest)
                 }
             }
                 
             else if social == "spotify"{
                 if let myURL = URL(string: "https://open.spotify.com/\(username)"){
                             let myRequest = URLRequest(url: myURL)
                             websiteWebView.load(myRequest)
                         }
                     }
         }

        
    }
    @IBAction func backDidTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

/*
 let appURL = URL(string: "snapchat://add/\(username)")!
         if application.canOpenURL(appURL) {
             application.open(appURL)

         } else {
             // if Snapchat app is not installed, open URL inside Safari
             let webURL = URL(string: "https://www.snapchat.com/add/\(username)")!
             application.open(webURL)

         }*/
