//
//  ViewController.swift
//  Color Match
//
//  Created by RB Embleton on 9/8/16.
//  Copyright © 2016 RB Embleton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = ( self.view.subviews.filter { (subview) in subview.isKindOfClass(ColorMatchGrid) } )[0] as? ColorMatchGrid
        scoreLabel.text = String(myView!.score)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

