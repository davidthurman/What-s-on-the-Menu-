//
//  ViewController.swift
//  testingpictures
//
//  Created by David Thurman on 4/2/16.
//  Copyright © 2016 David Thurman. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    var audioPlayer: AVAudioPlayer! // Global variable
    var slotMachine = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Slot Machine", ofType: "mp3")!)
    var picturesArray = [UIImage]()
    var numPictures: UInt32 = 0
    var cache = NSCache()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        let numberOfPicturesDefault = NSUserDefaults.standardUserDefaults()
        if let _ = numberOfPicturesDefault.valueForKey("Num"){
            let y = numberOfPicturesDefault.valueForKey("Num")!
            let int: Int = Int(y as! NSNumber)
            numPictures = UInt32(int)
        }
        self.imageView.image = UIImage(named: "What to Eat.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func getImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func shuffle(sender: AnyObject) {
        
        let numberOfPicturesDefault = NSUserDefaults.standardUserDefaults()
        if let _ = numberOfPicturesDefault.valueForKey("Num"){
            let y = numberOfPicturesDefault.valueForKey("Num")!
            let int: Int = Int(y as! NSNumber)
            numPictures = UInt32(int)
            
            if numPictures != 0{
                playSlots()
                var timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "pauseSlots", userInfo: nil, repeats: false)
                
                var diceRoll = Int(arc4random_uniform(numPictures) + 1)
                imageView.image = imageForKey("\(diceRoll)")
                delay(3.6){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(3.4){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(3.2){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(3){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(2.7){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(2.4){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(2.2){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(2){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(1.8){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(1.6){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(1.3){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(1.1){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(0.9){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(0.7){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(0.6){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(0.5){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(0.4){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(0.3){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(0.2){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                delay(0.1){
                    diceRoll = Int(arc4random_uniform(self.numPictures) + 1)
                    self.imageView.image = self.imageForKey("\(diceRoll)")
                }
                
            } else{
               self.imageView.image = UIImage(named: "What to Eat.png")
            }
        }
        
        
        
    }
    

    @IBAction func edit(sender: AnyObject) {
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picturesArray.append(image)
        numPictures++
        let numberOfPicturesDefault = NSUserDefaults.standardUserDefaults()
        numberOfPicturesDefault.setValue(Int(numPictures), forKey: "Num")
        numberOfPicturesDefault.synchronize()
        setImage(image, forKey: "\(numPictures)")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageURLForKey(key: String) -> NSURL{
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.URLByAppendingPathComponent(key)
    }
    
    func setImage(image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key)
        
        let imageURL = imageURLForKey(key)
        if let data = UIImageJPEGRepresentation(image, 0.5){
            data.writeToURL(imageURL, atomically: true)
            
        }
    }
    
    func imageForKey (key: String) -> UIImage? {
        cache = NSCache()
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
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    func playSlots() {
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Slot Machine", ofType: "mp3")!))
            self.audioPlayer.currentTime = 0
            self.audioPlayer.play()
            
        } catch {
            print("Error")
        }
    }
    func pauseSlots() {
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Slot Machine", ofType: "mp3")!))
            self.audioPlayer.stop()
            self.audioPlayer.currentTime = 0
            
        } catch {
            print("Error")
        }
    }
    
    
}

