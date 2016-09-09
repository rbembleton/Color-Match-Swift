//
//  ColorMatchGrid.swift
//  Color Match
//
//  Created by RB Embleton on 9/8/16.
//  Copyright © 2016 RB Embleton. All rights reserved.
//

import UIKit

class ColorMatchGrid: UIView {
    
    var myColors: [UIColor]
    var gridSize = CGFloat(6)
    var selectedCell: ColorMatchCell? = nil
    var score = 0
    
    func updateSelectedCell (cell: ColorMatchCell? ) {
        if (cell == nil) { selectedCell = nil; return }
        
        if ((selectedCell) != nil) {
        
            if (selectedCell!.backgroundColor == cell!.backgroundColor) {
                selectedCell!.removeFromSuperview()
                cell!.removeFromSuperview()
                selectedCell = nil
                
                self.score += 2
            } else {
                selectedCell!.toggleSelected()
                selectedCell = cell
            }
        
        } else {
            selectedCell = cell
        }
        
    }
    
    func setUpColors () {
        for _ in (0...(Int(gridSize * gridSize) / 2 - 1)) {
            let thisColor = UIColor(
                red:  CGFloat(Float(arc4random()) / 0xFFFFFFFF),
                green: CGFloat(Float(arc4random()) / 0xFFFFFFFF),
                blue: CGFloat(Float(arc4random()) / 0xFFFFFFFF),
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
            self.addSubview(ColorMatchCell(frame: myFrame, color: thisColor))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        myColors = []
        super.init(coder: aDecoder)
        setUpColors()
    }
    
    override init(frame: CGRect) {
        myColors = []
        super.init(frame: frame)
    }


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        makeGrid()
        super.drawRect(rect)
    }


}
