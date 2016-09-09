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
    
    func toggleSelected () {
        if selected == false {
            if let view = self.superview as? ColorMatchGrid { view.updateSelectedCell(self) }
            selected = true
            self.layer.shadowColor = UIColor.whiteColor().CGColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSizeZero
            self.layer.shadowRadius = 8
            self.layer.borderColor = UIColor.whiteColor().CGColor
            self.layer.borderWidth = 1.0
        } else {
            if let view = self.superview as? ColorMatchGrid { view.updateSelectedCell(nil) }
            selected = false
            self.layer.shadowOpacity = 0
            self.layer.borderWidth = 0
        }
    }
    
    init(frame: CGRect, color: UIColor) {
        self.color = color
        super.init(frame: frame)
        
        self.backgroundColor = color
        self.addTarget(self, action: #selector(toggleSelected), forControlEvents: .TouchDown)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }



}
