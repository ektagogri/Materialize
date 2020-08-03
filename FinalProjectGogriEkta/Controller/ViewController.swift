//
//  ViewController.swift
//  FinalProjectGogriEkta
//
//  Created by Ekta Gogri on 5/1/20.
//  Copyright © 2020 Ekta Gogri. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate,ARSessionDelegate{
   

    @IBOutlet weak var socialCard: UIButton!
    @IBOutlet weak var businessCard: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.socialCard.layer.cornerRadius = 30
        self.socialCard.layer.borderWidth = 1
        self.socialCard.layer.borderColor = UIColor.black.cgColor
        
        self.businessCard.layer.cornerRadius = 30
        self.businessCard.layer.borderWidth = 1
        self.businessCard.layer.borderColor = UIColor.black.cgColor
        
        super.viewDidAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
      }
}
