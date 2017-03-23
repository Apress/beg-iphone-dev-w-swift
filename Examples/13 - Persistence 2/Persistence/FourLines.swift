//
//  FourLines.swift
//  Persistence2
//
//  Created by Kim Topley on 8/2/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import Foundation

class FourLines : NSObject, NSCoding, NSCopying {
    var lines:[String]?
    let linesKey = "linesKey"
    
    override init() {
    }
    
    required init(coder decoder: NSCoder) {
        lines = decoder.decodeObjectForKey(linesKey) as? [String]
    }
    
    func encodeWithCoder(coder: NSCoder) {
        if let saveLines = lines {
            coder.encodeObject(saveLines, forKey: linesKey)
        }
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = FourLines()
        if var linesToCopy = lines {
            var newLines = Array<String>()
            for line in linesToCopy {
                newLines.append(line)
            }
            copy.lines = newLines
        }
        return copy
    }
}
