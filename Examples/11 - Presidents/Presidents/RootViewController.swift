//
//  RootViewController.swift
//  Presidents
//
//  Created by Kim Topley on 10/26/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        let splitVC = viewControllers[0] as! UIViewController
        let newTraits = traitCollection
        if newTraits.horizontalSizeClass == .Compact
                && newTraits.verticalSizeClass == .Compact {
            let childTraits = UITraitCollection(horizontalSizeClass: .Regular)
            setOverrideTraitCollection(childTraits, forChildViewController: splitVC)
        } else {
            setOverrideTraitCollection(nil, forChildViewController: splitVC)
        }
    }
}
