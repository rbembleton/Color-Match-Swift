//
//  ColorMatchCell.swift
//  Color Match
//
//  Created by RB Embleton on 9/8/16.
//  Copyright © 2016 RB Embleton. All rights reserved.
//

import UIKit

class ColorMatchCell: UIButton {

    var color: UIColor?
    var size: Float?
    var shadowView: UIView?
    
    func toggleSelected () {
        if isSelected == false {
            if let view = self.superview?.superview as? ColorMatchGrid { view.updateSelectedCell(self) }
            isSelected = true
            self.superview?.layer.shadowColor = UIColor.black.cgColor
            self.superview?.layer.shadowOpacity = 0.4
            self.superview?.layer.shadowOffset = CGSize.zero
            self.superview?.layer.shadowRadius = 8
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 2.0
        } else {
            if let view = self.superview?.superview as? ColorMatchGrid { view.updateSelectedCell(nil) }
            isSelected = false
            self.superview?.layer.shadowOpacity = 0
            self.layer.borderWidth = 0
        }
    }
    
    init(frame: CGRect, color: UIColor, size: Float) {
        self.color = color
        self.size = size
        super.init(frame: frame)
        
        self.backgroundColor = color
        
        self.addTarget(self, action: #selector(toggleSelected), for: .touchDown)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = CGFloat(self.size! / 20)
        self.clipsToBounds = true
        
        super.draw(rect)
    }



}
