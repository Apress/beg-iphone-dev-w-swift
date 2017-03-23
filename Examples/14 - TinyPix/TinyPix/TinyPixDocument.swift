//
//  TinyPixDocument.swift
//  TinyPix
//
//  Created by Kim Topley on 9/10/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class TinyPixDocument: UIDocument {
    private var bitmap: [UInt8]
    
    override init(fileURL: NSURL) {
        bitmap = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80]
        super.init(fileURL: fileURL)
    }
    
    func stateAt(#row: Int, column: Int) -> Bool {
        let rowByte = bitmap[row]
        let result = UInt8(1 << column) & rowByte
        return result != 0
    }
    
    func setState(state: Bool, atRow row: Int, column: Int) {
        var rowByte = bitmap[row]
        if state {
            rowByte |= UInt8(1 << column)
        } else {
            rowByte &= ~UInt8(1 << column)
        }
        bitmap[row] = rowByte
    }
    
    func toggleStateAt(#row: Int, column: Int) {
        let state = stateAt(row: row, column: column)
        setState(!state, atRow: row, column: column)
    }
    
    override func contentsForType(typeName: String, error outError: NSErrorPointer) -> AnyObject? {
        println("Saving document to URL \(fileURL)")
        let bitmapData = NSData(bytes: bitmap, length: bitmap.count)
        return bitmapData
    }
    
    override func loadFromContents(contents: AnyObject, ofType typeName: String,
                error outError: NSErrorPointer) -> Bool {
        println("Loading document from URL \(fileURL)")
        let bitmapData = contents as! NSData
        bitmapData.getBytes(UnsafeMutablePointer<UInt8>(bitmap), length: bitmap.count)
        return true
    }
}
