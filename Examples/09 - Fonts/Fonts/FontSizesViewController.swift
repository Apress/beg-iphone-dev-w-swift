//
//  FontSizesViewController.swift
//  Fonts
//
//  Created by Kim Topley on 10/12/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class FontSizesViewController: UITableViewController {
    var font: UIFont!
    private var pointSizes: [CGFloat] {
        struct Constants {
            static let pointSizes: [CGFloat] = [
                9, 10, 11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96, 144
            ]
        }
        return Constants.pointSizes
    }
    private let cellIdentifier = "FontNameAndSize"

    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let pointSize = pointSizes[indexPath.row]
        return font.fontWithSize(pointSize)
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return pointSizes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = font.fontName
        cell.detailTextLabel?.text = "\(pointSizes[indexPath.row]) point"
        
        return cell
    }
}
