//
//  ViewController.swift
//  Persistence
//
//  Created by Kim Topley on 8/2/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lineFields:[UITextField]!
    private let rootKey = "rootKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let filePath = self.dataFilePath()
        if (NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
            let data = NSMutableData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            let fourLines = unarchiver.decodeObjectForKey(rootKey) as! FourLines
            unarchiver.finishDecoding()
            
            if let newLines = fourLines.lines {
                for var i = 0; i < newLines.count; i++ {
                    lineFields[i].text = newLines[i]
                }
            }
        }
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "applicationWillResignActive:",
                name: UIApplicationWillResignActiveNotification,
                object: app)
    }
    
    func applicationWillResignActive(notification:NSNotification) {
        let filePath = self.dataFilePath()
        let fourLines = FourLines()
        let array = (self.lineFields as NSArray).valueForKey("text") as! [String]
        fourLines.lines = array
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(fourLines, forKey: rootKey)
        archiver.finishEncoding()
        data.writeToFile(filePath, atomically: true)
    }
    
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(
                        NSSearchPathDirectory.DocumentDirectory,
                        NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        return documentsDirectory.stringByAppendingPathComponent("data.archive") as String
    }
}

