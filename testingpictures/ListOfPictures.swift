//
//  ListOfPictures.swift
//  testingpictures
//
//  Created by David Thurman on 4/3/16.
//  Copyright © 2016 David Thurman. All rights reserved.
//

import Foundation
import UIKit

class ListOfPictures: UITableViewController{
    
    var cache = NSCache()
    var numPictures: UInt32 = 0    
    var listOfPics = [UIImage]()
    var refreshController: UIRefreshControl!
    //var tableViewController = UITableViewController(style: .Plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.refreshController = UIRefreshControl()
        self.refreshController.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshController.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshController) // not required when using UITableViewController
        
        
        
        let numberOfPicturesDefault = NSUserDefaults.standardUserDefaults()
        if let _ = numberOfPicturesDefault.valueForKey("Num"){
            let y = numberOfPicturesDefault.valueForKey("Num")!
            let int: Int = Int(y as! NSNumber)
            numPictures = UInt32(int)

            for(var x: Int = 1; x <= int; x++){
                self.listOfPics.append(imageForKey("\(x)")!)
            }

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfPics.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var count : UIImage
        count = listOfPics[indexPath.row]
        cell.imageView?.image = count
        return cell
    }
    func imageForKey (key: String) -> UIImage? {
        if let existingImage = cache.objectForKey(key) as? UIImage {
            return existingImage
        }
        let imageURL = imageURLForKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else{
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key)
        
        return imageFromDisk
    }
    func imageURLForKey(key: String) -> NSURL{
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.URLByAppendingPathComponent(key)
    }
    func deleteImageForKey(key: String){
        cache.removeObjectForKey(key)
        let imageURL = imageURLForKey(key)
        do{
            try NSFileManager.defaultManager().removeItemAtURL(imageURL)
        }
        catch {
            print("Error removing the image from disk: \(error)")
        }
        
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let numberOfPicturesDefault = NSUserDefaults.standardUserDefaults()
        if let _ = numberOfPicturesDefault.valueForKey("Num"){
            let y = numberOfPicturesDefault.valueForKey("Num")!
            let int: Int = Int(y as! NSNumber)
            numPictures = UInt32(int)
        }
        
            
            
        if editingStyle == UITableViewCellEditingStyle.Delete {
            listOfPics.removeAtIndex(indexPath.row)
            cache = NSCache()
            let chosenPic = indexPath.row + 1
            //Delete a pic
            deleteImageForKey("\(chosenPic)")
            for(var x: Int = chosenPic; x <= Int(numPictures - 1); x++){
                let placeHolderPic: UIImage = imageForKey("\(x+1)")!
                setImage(placeHolderPic, forKey: "\(x)")
                cache.setObject(placeHolderPic, forKey: x)
            }
            deleteImageForKey("\(numPictures)")
            
            numPictures--
            let numberOfPicturesDefault = NSUserDefaults.standardUserDefaults()
            numberOfPicturesDefault.setValue(Int(numPictures), forKey: "Num")
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    func setImage(image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key)
        
        let imageURL = imageURLForKey(key)
        if let data = UIImageJPEGRepresentation(image, 0.5){
            data.writeToURL(imageURL, atomically: true)
            
        }
    }

    func refresh(sender:AnyObject)
    {
        let numberOfPicturesDefault = NSUserDefaults.standardUserDefaults()
        if let _ = numberOfPicturesDefault.valueForKey("Num"){
            let y = numberOfPicturesDefault.valueForKey("Num")!
            let int: Int = Int(y as! NSNumber)
            numPictures = UInt32(int)
            self.listOfPics.removeAll()
            for(var x: Int = 1; x <= int; x++){
                self.listOfPics.append(imageForKey("\(x)")!)
            }
            
            self.tableView.reloadData()
        }
        self.refreshController.endRefreshing()
    }
    
    
}
