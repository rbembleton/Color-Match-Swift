//
//  ViewController.swift
//  Color Match
//
//  Created by RB Embleton on 9/9/16.
//  Copyright © 2016 RB Embleton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        print(segue)
        if (segue.identifier == "standardLevelSegue") {
            let svc = segue.destination as! LevelViewController;
            svc.levelDifficulty = 4
        } else if (segue.identifier == "hardLevelSegue") {
            let svc = segue.destination as! LevelViewController;
            svc.levelDifficulty = 6
        }
    }

}
