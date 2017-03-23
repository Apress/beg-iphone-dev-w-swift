//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by Kim Topley on 9/13/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let date = NSDate()
        datePicker.setDate(date, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        let date = datePicker.date
        let message = "The date and time you selected is \(date)"
        let alert = UIAlertController(
                        title: "Date and Time Selected",
                        message: message,
                        preferredStyle: .Alert)
        let action = UIAlertAction(
                        title: "That's so true!",
                        style: .Default,
                        handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}
