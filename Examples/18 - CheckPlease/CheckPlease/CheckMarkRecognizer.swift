//
//  CheckMarkRecognizer.swift
//  CheckPlease
//
//  Created by Kim Topley on 7/24/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit
//import UIKit.UIGestureRecognizerSubclass

class CheckMarkRecognizer: UIGestureRecognizer {
    private let minimumCheckMarkAngle = CGFloat(50)
    private let maximumCheckMarkAngle = CGFloat(135)
    private let minimumCheckMarkLength = CGFloat(10)
    
    private var lastPreviousPoint = CGPointZero
    private var lastCurrentPoint = CGPointZero
    private var lineLengthSoFar = CGFloat(0)
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        let touch = touches.first as! UITouch
        let point = touch.locationInView(view)
        lastPreviousPoint = point
        lastCurrentPoint = point
        lineLengthSoFar = 0;
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        let touch = touches.first as! UITouch
        let previousPoint = touch.previousLocationInView(view)
        let currentPoint = touch.locationInView(view)
        let angle = angleBetweenLines(lastPreviousPoint, lastCurrentPoint,
                                      previousPoint,  currentPoint)
        
        if angle >= minimumCheckMarkAngle && angle <= maximumCheckMarkAngle
                && lineLengthSoFar > minimumCheckMarkLength {
            state = .Ended
        }
        lineLengthSoFar += distanceBetweenPoints(previousPoint, currentPoint)
        lastPreviousPoint = previousPoint
        lastCurrentPoint = currentPoint
    }
}
