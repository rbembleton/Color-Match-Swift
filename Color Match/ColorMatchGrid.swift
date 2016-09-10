//
//  ColorMatchGrid.swift
//  Color Match
//
//  Created by RB Embleton on 9/8/16.
//  Copyright © 2016 RB Embleton. All rights reserved.
//

import UIKit

extension UIColor {
    static func appleBlue() -> UIColor {
        return UIColor.init(colorLiteralRed: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0)
    }
}

class ColorMatchGrid: UIView {
    
    var myColors: [UIColor]
    var gridSize = CGFloat(4)
    var levelTimer = 30
    var selectedCell: ColorMatchCell? = nil
    
    var recolorButton : UIButton?
    
    var score = 0
    var scoreLabel : UILabel?
    
    var timerLabel : UILabel?
    var timer = 30
    
    var level = 1
    var levelMod : Float = 1.0
    var redMod : Float = 0.0
    var greenMod : Float = 0.0
    var blueMod : Float = 0.0
    
    func updateSelectedCell (cell: ColorMatchCell? ) {
        if (cell == nil) { selectedCell = nil; return }
        
        if ((selectedCell) != nil) {
        
            if (selectedCell!.backgroundColor == cell!.backgroundColor) {
                self.recolorButton!.enabled = false
                selectedCell!.removeFromSuperview()
                cell!.removeFromSuperview()
                checkLevelOver()
                selectedCell = nil
                self.score += (2 * level)
                scoreLabel!.text = String(score)
            } else {
                selectedCell!.toggleSelected()
                selectedCell = cell
            }
        
        } else {
            selectedCell = cell
        }
        
    }
    
    func checkLevelOver () {
        if self.subviews.count == 0 {
            level += 1
            timer = levelTimer
            self.recolorButton!.enabled = true
            self.setUpColors()
            self.makeGrid()
        }
    }
    
    func levelRecolor () {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.setUpColors()
        self.makeGrid()
    }
    
    func setUpColors () {
        levelMod = 1.0 / Float(level)
        redMod = (Float(arc4random()) * Float(1.0 - levelMod) / 0xFFFFFFFF)
        blueMod = (Float(arc4random()) * Float(1.0 - levelMod)  / 0xFFFFFFFF)
        greenMod = (Float(arc4random()) * Float(1.0 - levelMod) / 0xFFFFFFFF)
        
        for _ in (0...(Int(gridSize * gridSize) / 2 - 1)) {
            let thisColor = UIColor(
                red:  CGFloat(redMod + levelMod * Float(arc4random()) / 0xFFFFFFFF),
                green: CGFloat(greenMod + levelMod * Float(arc4random()) / 0xFFFFFFFF),
                blue: CGFloat(blueMod + levelMod * Float(arc4random()) / 0xFFFFFFFF),
                alpha: 1.0)
            for _ in (0...1) { myColors.append(thisColor) }
        }
        
    }
    
    func randColor() -> UIColor {
        let randIdx = Int(arc4random_uniform(UInt32(myColors.count)))
        let randColor = myColors[randIdx]
        myColors.removeAtIndex(randIdx)
        return randColor
    }
    
    func makeGrid () {
        let myHeight = self.bounds.height
        let cellSize = (myHeight - 10) / gridSize
        for pos in (0...(Int(gridSize * gridSize) - 1)) {
            let thisColor = randColor()
            let myFrame = CGRect(x: (CGFloat(pos) % gridSize * cellSize + 10), y: (CGFloat(Int(CGFloat(pos) / gridSize)) * cellSize + 10), width: cellSize - 10, height: cellSize - 10)
            self.addSubview(ColorMatchCell(frame: myFrame, color: thisColor, size: Float(cellSize)))
        }
    }
    
    func updateDifficulty (level: Int) {
        gridSize = CGFloat(level)
        levelTimer = level == 4 ? 30 : 60
        timer = levelTimer
        setUpColors()
    }
    
    func updateTimer () -> Bool {
        timer -= 1
        let setText = ("00:" + (timer < 10 ? "0" : "") + (timer > 0 ? String(timer) : "0"))
        timerLabel!.text = setText
        
        return timer > 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        myColors = []
        super.init(coder: aDecoder)
//        setUpColors()
    }
    
    override init(frame: CGRect) {
        myColors = []
        super.init(frame: frame)
    }


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        makeGrid()
        scoreLabel!.text = String(score)
        super.drawRect(rect)
    }


}
