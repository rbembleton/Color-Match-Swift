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
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var recolorButton: UIButton!
    
    var thisTimer : NSTimer?
    
    @IBAction func recolorButton(sender: AnyObject) {
        let matchGrid = ( self.view.subviews.filter { (subview) in subview.isKindOfClass(ColorMatchGrid) } )[0] as? ColorMatchGrid
        matchGrid!.levelRecolor()
    }
    
    func updateFontSizes () {
        let smaller = min(self.view.bounds.size.height, self.view.bounds.size.width)
        
        for subview in self.view.subviews {
            if let thisLabel = subview as? UILabel {
                thisLabel.font = thisLabel.font.fontWithSize(thisLabel.font.pointSize * (CGFloat(smaller / 50)) / 6.5)
            }
            
            if let thisButton = subview as? UIButton {
                thisButton.titleLabel!.font = thisButton.titleLabel!.font.fontWithSize(thisButton.titleLabel!.font.pointSize * (CGFloat(smaller / 50)) / 6.5)
            }
        }
    }
    
    func updateTimer () {
        let matchGrid = ( self.view.subviews.filter { (subview) in subview.isKindOfClass(ColorMatchGrid) } )[0] as? ColorMatchGrid
        let keepGoing = matchGrid?.updateTimer()
        
        
        if keepGoing == false {
            thisTimer?.invalidate()
            let defaults = NSUserDefaults.standardUserDefaults()
            var highScore : Int? = Int(defaults.stringForKey("colorMatchHighScore")!)
            if highScore == nil || matchGrid!.score > highScore {
                defaults.setValue("\(matchGrid!.score)", forKey: "colorMatchHighScore")
                highScore = matchGrid!.score
            }
            
            
            let alertController = UIAlertController(title: "Game Over", message:
                "Great job! Your score: \(matchGrid!.score)\nYour high score: \(highScore!)", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let matchGrid = ( self.view.subviews.filter { (subview) in subview.isKindOfClass(ColorMatchGrid) } )[0] as? ColorMatchGrid
        matchGrid?.scoreLabel = scoreLabel
        matchGrid?.timerLabel = timerLabel
        matchGrid?.recolorButton = recolorButton
        
        if (matchGrid != nil) { thisTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true) }
        
        updateFontSizes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

