//
//  HighScoreViewController.swift
//  Color Match
//
//  Created by RB Embleton on 9/9/16.
//  Copyright © 2016 RB Embleton. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController {

    @IBOutlet weak var standardLevelLabel: UILabel!
    @IBOutlet weak var hardLevelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        standardLevelLabel.text = "Standard Level: \(((defaults.stringForKey("colorMatchHighScore4")) != nil ? Int(defaults.stringForKey("colorMatchHighScore4")!) : 0)!)"
        hardLevelLabel.text = "Hard Level: \((defaults.stringForKey("colorMatchHighScore6") != nil ? Int(defaults.stringForKey("colorMatchHighScore6")!) : 0 )!)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
