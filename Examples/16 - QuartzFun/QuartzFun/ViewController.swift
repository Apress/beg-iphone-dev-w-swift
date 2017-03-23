//
//  ViewController.swift
//  QuartzFun
//
//  Created by Kim Topley on 6/20/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var colorControl: UISegmentedControl!
    
    @IBAction func changeColor(sender: UISegmentedControl) {
        let drawingColorSelection = DrawingColor(rawValue: UInt(sender.selectedSegmentIndex))
        if let drawingColor = drawingColorSelection {
            let funView = view as! QuartzFunView;
            switch drawingColor {
            case .Red:
                funView.currentColor = UIColor.redColor()
                funView.useRandomColor = false
 
            case .Blue:
                funView.currentColor = UIColor.blueColor()
                funView.useRandomColor = false

            case .Yellow:
                funView.currentColor = UIColor.yellowColor()
                funView.useRandomColor = false

            case .Green:
                funView.currentColor = UIColor.greenColor()
                funView.useRandomColor = false

            case .Random:
                funView.useRandomColor = true

            default:
                break;
            }
        }
    }
    
    
    @IBAction func changeShape(sender: UISegmentedControl) {
        let shapeSelection = Shape(rawValue: UInt(sender.selectedSegmentIndex))
        if let shape = shapeSelection {
            let funView = view as! QuartzFunView;
            funView.shape = shape;
            colorControl.hidden = shape == Shape.Image
        }
    }
}

