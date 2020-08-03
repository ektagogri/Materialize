//
//  DoneViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/5/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {

    @IBOutlet weak var createNew: UIButton!
    @IBOutlet weak var goBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            self.createNew.backgroundColor = .white
              self.createNew.layer.cornerRadius = 30
              self.createNew.layer.borderWidth = 1
              self.createNew.layer.borderColor = UIColor.black.cgColor
              
              self.goBack.backgroundColor = .white
              self.goBack.layer.cornerRadius = 30
              self.goBack.layer.borderWidth = 1
              self.goBack.layer.borderColor = UIColor.black.cgColor
    }
    //pass appropriate values to segue destination
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
        if let tabBarController = (segue.destination as? UITabBarController){
            if segue.identifier == "create"{
                    tabBarController.selectedIndex = 1
                
            }
        }
    }
}
