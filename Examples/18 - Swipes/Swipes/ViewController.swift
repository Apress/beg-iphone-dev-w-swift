//
//  ViewController.swift
//  Swipes
//
//  Created by Kim Topley on 7/23/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label:UILabel!
    private var gestureStartPoint:CGPoint!
    
    private let minimumGestureLength = Float(25.0)
    private let maximumVariance = Float(5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        gestureStartPoint = touch.locationInView(self.view)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let currentPosition = touch.locationInView(self.view)
        
        let deltaX = fabsf(Float(gestureStartPoint.x - currentPosition.x))
        let deltaY = fabsf(Float(gestureStartPoint.y - currentPosition.y))
        
        if deltaX >= minimumGestureLength && deltaY <= maximumVariance {
            label.text = "Horizontal swipe detected"
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
                           dispatch_get_main_queue(),
                           { self.label.text = "" })
        } else if deltaY >= minimumGestureLength && deltaX <= maximumVariance {
            label.text = "Vertical swipe detected"
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
                           dispatch_get_main_queue(),
                           { self.label.text = "" })
        }
    }
}

