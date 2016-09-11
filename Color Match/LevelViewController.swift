//
//  LevelViewController.swift
//  Color Match
//
//  Created by RB Embleton on 9/8/16.
//  Copyright © 2016 RB Embleton. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var recolorButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    
    var thisTimer : Timer?
    var levelDifficulty = 4
    
    @IBAction func recolorButton(_ sender: AnyObject) {
        let matchGrid = ( self.view.subviews.filter { (subview) in subview.isKind(of: ColorMatchGrid.self) } )[0] as? ColorMatchGrid
        matchGrid!.levelRecolor()
    }
    
    func updateFontSizes () {
//        let smaller = min(self.view.bounds.size.height, self.view.bounds.size.width)
//        
//        for subview in self.view.subviews {
//            if let thisLabel = subview as? UILabel {
//                thisLabel.font = thisLabel.font.fontWithSize(thisLabel.font.pointSize * (CGFloat(smaller / 50)) / 10)
//            }
//            
//            if let thisButton = subview as? UIButton {
//                thisButton.titleLabel!.font = thisButton.titleLabel!.font.fontWithSize(thisButton.titleLabel!.font.pointSize * (CGFloat(smaller / 50)) / 10)
//            }
//        }
    }
    
    func updateTimer () {
        let matchGrid = ( self.view.subviews.filter { (subview) in subview.isKind(of: ColorMatchGrid.self) } )[0] as? ColorMatchGrid
        let keepGoing = matchGrid?.updateTimer()
        
        
        if keepGoing == false {
            thisTimer?.invalidate()
            let defaults = UserDefaults.standard
            var highScore = (defaults.string(forKey: "colorMatchHighScore\(self.levelDifficulty)"))
            if highScore == nil || matchGrid!.score > Int(highScore!)! {
                defaults.setValue("\(matchGrid!.score)", forKey: "colorMatchHighScore\(self.levelDifficulty)")
                highScore = String(matchGrid!.score)
            }
            
            
            let alertController = UIAlertController(title: "Game Over", message:
                "Great job! Your score: \(matchGrid!.score)\nYour high score: \(highScore!)", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let matchGrid = ( self.view.subviews.filter { (subview) in subview.isKind(of: ColorMatchGrid.self) } )[0] as? ColorMatchGrid
        matchGrid?.updateDifficulty(levelDifficulty)
        matchGrid?.scoreLabel = scoreLabel
        matchGrid?.timerLabel = timerLabel
        matchGrid?.levelLabel = levelLabel
        matchGrid?.recolorButton = recolorButton
        
        recolorButton.setTitleColor(UIColor.lightGray, for: .disabled)
        
        if (matchGrid != nil) { thisTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true) }
        
        updateFontSizes()
    }


}

