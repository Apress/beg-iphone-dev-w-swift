//
//  DetailViewController.swift
//  Presidents
//
//  Created by Kim Topley on 10/25/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPopoverControllerDelegate {
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    private var languageButton: UIBarButtonItem?
    private var languagePopoverController: UIPopoverController?
    var languageString: String = "" {
        didSet {
            if (languageString != oldValue) {
                configureView()
            }
            if let popoverController = languagePopoverController {
                popoverController.dismissPopoverAnimated(true)
                languagePopoverController = nil
            }
        }
    }

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                let dict = detail as! [String: String]
                let urlString = modifyUrlForLanguage(url: dict["url"]!, language: languageString)
                label.text = urlString
                
                let url = NSURL(string: urlString)!
                let request = NSURLRequest(URL: url)
                webView.loadRequest(request)
                
                let name = dict["name"]!
                title = name
            }
        }
    }
    
    private func modifyUrlForLanguage(#url: String, language lang: String?) -> String {
        var newUrl = url
        
        // We're relying on a particular Wikipedia URL format here. This
        // is a bit fragile!
        if let langStr = lang {
            // URL is like http://en.wikipedia……
            let range = NSMakeRange(7, 2)
            if !langStr.isEmpty && (url as NSString).substringWithRange(range) != langStr {
                newUrl = (url as NSString).stringByReplacingCharactersInRange(range, withString: langStr)
            }
        }
        
        return newUrl
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            languageButton = UIBarButtonItem(title: "Choose Language", style: .Plain, target: self, action: "toggleLanguagePopover")
            navigationItem.rightBarButtonItem = languageButton
        }
        
        self.configureView()
    }
    
    func toggleLanguagePopover() {
        if languagePopoverController == nil {
            let languageListController = LanguageListController()
            languageListController.detailViewController = self
            languagePopoverController = UIPopoverController(contentViewController: languageListController)
            languagePopoverController?.presentPopoverFromBarButtonItem(languageButton!, permittedArrowDirections: .Any, animated: true)
        } else {
            languagePopoverController?.dismissPopoverAnimated(true)
            languagePopoverController = nil
        }
    }
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        if popoverController == languagePopoverController {
            languagePopoverController = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

