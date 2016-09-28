//
//  ViewController.swift
//  PocketNote
//
//  Created by Yu-Lin Yang on 6/23/16.
//  Copyright © 2016 Yu-Lin Yang. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextViewDelegate, SettingsVCDelegate {
    
    //MARK: Variables
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var rightTop: UIBarButtonItem!
    @IBOutlet weak var navTitle: UINavigationItem!
    var settingsButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    var doneButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
    var noteToday = String()
    


    //MARK: SettingsVCDelegate Protocol Methods
    var dateToggle = false;
    var backgroundColor = UIImage(named: "paper.jpg")
    var imageView   = UIImageView(image: UIImage(named: "paper.jpg"));
    
    func adjustDate(_ data: Bool) {
        print("adj date"+String(data))
        dateToggle = data
        setDate()
    }
    func adjustTimer(_ data: Int) {
        print("adj timer "+String(data))
        timerSelection = data
        setTimer()
    }
    func adjustBackground(_ data: UIImage) {
        print("adj background "+String(describing: data))
        if( data != backgroundColor) {
            imageView.removeFromSuperview()
            print("removed")
        }
        backgroundColor = data
        imageView = UIImageView(frame: self.view.bounds);
        imageView.image = backgroundColor
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        print("adjbg is running")
    }
    
    //MARK: Normal Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimer()
        
        
        //Note setup
        note.delegate   = self
        note.text       = "Write a quick note or reminder."
        note.font       = UIFont(name: "Noteworthy", size: 17)
        note.textColor  = UIColor.darkGray
        note.textColor = UIColor.lightGray
        note.backgroundColor = UIColor.clear
        adjustBackground(backgroundColor!)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 20)!]
        
        //Allows user to Dismiss Keyboard
        let myGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedAwayFunction(_:)))
        self.view.addGestureRecognizer(myGesture)
        
        setDate()
        
        //Manually causing button click on Settings Button and Trash Button
        settingsButton.setImage(UIImage(named: "settings_icon.png"), for: UIControlState())
        settingsButton.target(forAction: #selector(ViewController.settingButtonPressed), withSender: self)
        settingsButton.addTarget(self, action: #selector(ViewController.settingButtonPressed), for: UIControlEvents.touchUpInside)
        
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.target(forAction: #selector(ViewController.doneButtonPressed), withSender: self)
        doneButton.addTarget(self, action: #selector(ViewController.doneButtonPressed), for: UIControlEvents.touchUpInside)
        
        let rightItem:UIBarButtonItem = UIBarButtonItem()
        rightItem.customView = settingsButton
        navTitle.rightBarButtonItem = rightItem
        
        
        //Save
        let stringKey = UserDefaults.standard
        if(stringKey.string(forKey: "savedStringKey") != nil) {
            noteToday = stringKey.string(forKey: "savedStringKey")!
    }
        else {
            print("first time huh")
        }
        /**if(stringKey.stringForKey("bgColor") != nil) {
            imageView   = UIImageView(image: UIImage(named: "paper.jpg"));
        }*/
        
        
        
    }
    func tappedAwayFunction(_ sender: UITapGestureRecognizer) {
        note.resignFirstResponder()
    }
    
    
    
    
    
    
    
    
    
    //MARK: Settings Stuff
    func doneButtonPressed() {
        note.resignFirstResponder()
    }
    func settingButtonPressed() {
        print("\n\n")
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! SettingsVC
        popOverVC.timerSelection = timerSelection
        popOverVC.backgroundColor = backgroundColor!
        popOverVC.dateToggle = dateToggle
    
        popOverVC.view.frame = self.view.frame
        popOverVC.didMove(toParentViewController: self)
        popOverVC.delegate = self
        self.view.addSubview(popOverVC.view)
        self.addChildViewController(popOverVC)
    }
    
    
    
    
    
    
    //MARK: Trash
    @IBAction func trashClicked(_ sender: AnyObject) {
        note.text = ""
    }
    
    //MARK: Notification stuff
    var timer = Timer()
    var timerSelection = 0
    func notify() {
        print("notifications is being called")
        let Notification = UILocalNotification()
        //Notification.alertAction = "go back to the app"
        Notification.alertBody = note.text
        Notification.timeZone = TimeZone.current
        Notification.fireDate = Date(timeIntervalSinceNow: 1)
        UIApplication.shared.scheduleLocalNotification(Notification)
    }
    func setTimer() {
        var i = 0.0
        switch timerSelection {
        case 1:
            i = 9
        case 2:
            i = 3600
        case 3:
            i = 18000
        case 4:
            i = 36000
        default:
            break
        }
        if i > 0 {
            timer = Timer.scheduledTimer(timeInterval: i, target: self, selector: #selector(ViewController.notify), userInfo: nil, repeats: true)
        }
        else {
            timer.invalidate()
        }
    }
    
    
    
    
    //MARK: textView Methods
    func textViewDidBeginEditing(_ note: UITextView) {
        if note.textColor == UIColor.lightGray {
            note.text = nil
            note.textColor = UIColor.black
        }
        let rightItem:UIBarButtonItem = UIBarButtonItem()
        rightItem.customView = doneButton
        navTitle.rightBarButtonItem = rightItem
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write a quick note or reminder."
            textView.textColor = UIColor.lightGray
        }
        let rightItem:UIBarButtonItem = UIBarButtonItem()
        rightItem.customView = settingsButton
        navTitle.rightBarButtonItem = rightItem

        let myText = note.text
        UserDefaults.standard.set(myText, forKey: "savedStringKey")
        UserDefaults.standard.synchronize()
    }
    
    
    //MARK: Other Methods
    func setDate() {
        //Setting the Date
        if(dateToggle) {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.dateStyle = DateFormatter.Style.full
            navTitle.title = dateFormatter.string(from: currentDate)
        }
        else {
            navTitle.title = "Welcome"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

