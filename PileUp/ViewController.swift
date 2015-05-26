//
//  ViewController.swift
//  PileUp
//
//  Created by nagata on 4/30/15.
//  Copyright (c) 2015 nagata. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let scene = GameScene()
        
        let view = self.view as! SKView
        
        view.showsFPS = false
        
        view.showsNodeCount = false
        
        scene.size = view.frame.size
        
        view.presentScene(scene)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

