//
//  RoundedUIView.swift
//  Color Match
//
//  Created by RB Embleton on 9/11/16.
//  Copyright © 2016 RB Embleton. All rights reserved.
//

import UIKit

class RoundedUIView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        super.draw(rect)
    }
    

}
