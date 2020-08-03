//
//  SavedTableViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/6/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit

class SavedTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    
    @IBOutlet var savedCardsTableView: UITableView!
    var gmailID:String = ""
    public var mode:String=""
    private var socialModel = SocialCardsModel.sharedInstance
    private var businessModel = BusinessCardsModel.sharedInstance
    
      override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         savedCardsTableView.reloadData()
      }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mode == "Social"{
            return socialModel.getSaved(gmailID: gmailID).count
        }
       else if mode == "Busiess"{
           return businessModel.getSaved(gmailID: gmailID).count
        }
        return 0
     }

    @IBAction func backDidTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    //set cards based on card type
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell")!
        if mode == "Social"{
         let card = socialModel.getSaved(gmailID: gmailID)[indexPath.row]
            cell.textLabel?.text = "\(mode) Card for \(card.getName())"
        }
        else if mode == "Busiess"{
            let card = businessModel.getSaved(gmailID: gmailID)[indexPath.row]
            cell.textLabel?.text = "\(mode) Card for \(card.getName())"
         }

        return cell
        }
}
