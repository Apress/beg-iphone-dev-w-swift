//
//  ViewController.swift
//  ShakeAndBreak
//
//  Created by Kim Topley on 7/5/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var imageView:UIImageView!
    private var fixed:UIImage!
    private var broken:UIImage!
    private var brokenScreenShowing = false
    private var crashPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSBundle.mainBundle().URLForResource("glass", withExtension:"wav")

        var createError:NSError?
        crashPlayer = AVAudioPlayer(contentsOfURL: url, error: &createError)
        if self.crashPlayer == nil {
            if let error = createError {
                println("Audio error! \(error.localizedDescription)")
            }
        }

        fixed = UIImage(named:"home")
        broken = UIImage(named:"homebroken")
        imageView.image = fixed
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        imageView.image = fixed
        brokenScreenShowing = false
    }

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if !brokenScreenShowing && motion == .MotionShake {
            imageView.image = broken
            crashPlayer.play()
            brokenScreenShowing = true
        }
    }
}


