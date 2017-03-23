//
//  ViewController.swift
//  Button Fun
//
//  Created by Kim Topley on 9/11/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func buttonPressed(sender: UIButton) {
        let title = sender.titleForState(.Normal)!
        let plainText = "\(title) button pressed"
        let styledText = NSMutableAttributedString(string: plainText)
        
        let attributes = [
            NSFontAttributeName:
                     UIFont.boldSystemFontOfSize(statusLabel.font.pointSize)
        ]
        let nameRange = (plainText as NSString).rangeOfString(title)
        styledText.setAttributes(attributes, range: nameRange)
        
        statusLabel.attributedText = styledText
    }
}

