//
//  FontListViewController.swift
//  Fonts
//
//  Created by Kim Topley on 10/12/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
    var fontNames: [String] = []
    var showsFavorites:Bool = false
    private var cellPointSize: CGFloat!
    private let cellIdentifier = "FontName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
        
        if showsFavorites {
            navigationItem.rightBarButtonItem = editButtonItem()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavorites {
            fontNames = FavoritesList.sharedFavoriteList.favorites
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return fontNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return showsFavorites
    }
    
    override func tableView(tableView: UITableView,
            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
            forRowAtIndexPath indexPath: NSIndexPath) {
        if !showsFavorites {
            return
        }
                
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the data source
            let favorite = fontNames[indexPath.row]
            FavoritesList.sharedFavoriteList.removeFavorite(favorite)
            fontNames = FavoritesList.sharedFavoriteList.favorites
            
            tableView.deleteRowsAtIndexPaths([indexPath],
                    withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView,
                       moveRowAtIndexPath sourceIndexPath: NSIndexPath,
        toIndexPath destinationIndexPath: NSIndexPath) {
        FavoritesList.sharedFavoriteList.moveItem(fromIndex: sourceIndexPath.row,
                                                  toIndex: destinationIndexPath.row)
        fontNames = FavoritesList.sharedFavoriteList.favorites
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(tableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath)
        
        if segue.identifier == "ShowFontSizes" {
            let sizesVC =  segue.destinationViewController as! FontSizesViewController
            sizesVC.title = font.fontName
            sizesVC.font = font
        } else {
            let infoVC = segue.destinationViewController as! FontInfoViewController
            infoVC.font = font
            infoVC.favorite = contains(FavoritesList.sharedFavoriteList.favorites, font.fontName)
        }
    }
}
