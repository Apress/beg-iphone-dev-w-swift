//
//  SKNode+Extra.swift
//  TextShooter
//
//  Created by Kim Topley on 9/15/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import Foundation
import SpriteKit

extension SKNode {
    func receiveAttacker(attacker: SKNode, contact: SKPhysicsContact) {
        // Default implementation does nothing
    }
    
    func friendlyBumpFrom(node: SKNode) {
        // Default implementation does nothing
    }
}
