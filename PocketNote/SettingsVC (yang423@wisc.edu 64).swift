//
//  SettingsVC.swift
//  PocketNote
//
//  Created by Yu-Lin Yang on 7/11/16.
//  Copyright © 2016 Yu-Lin Yang. All rights reserved.
//

import UIKit




class SettingsVC: UIViewController, UITextViewDelegate {
    var emptyPopUp = true
    var delegate : SettingsVCDelegate?
    var dateToggle = true
    var backgroundColor = UIImage()
    @IBOutlet weak var fg: UIView!
    @IBOutlet weak var on: UIButton!
    @IBOutlet weak var offDate: UIButton!
    let logoImage: [UIImage] = [
        UIImage(named: "paper.jpg")!,
        UIImage(named: "paper_blue.jpg")!,
        UIImage(named: "paper_brown.jpg")!,
        UIImage(named: "paper_green.jpg")!,
        UIImage(named: "paper_orange.jpg")!
    ]
    //[[UIImage imageNamed:@"image_name"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    override func viewDidLoad() {
        super.viewDidLoad()
        fg.layer.cornerRadius = 8.0
        fg.clipsToBounds = true

        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        self.showAnimate()
        
        if dateToggle {
            on.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        }
        else {
            offDate.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        }
        print(timerSelection)
        if timerSelection == 0 {
            offNotif.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        }
        else if timerSelection == 1 {
            quarterHr.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        }
        else if timerSelection == 2 {
            oneHr.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        }
        else if timerSelection == 3 {
            fiveHr.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        }
        else if timerSelection == 4 {
            tenHr.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        }
        
        var i = (UIScreen.mainScreen().bounds.width - fg.frame.width)/2 + 38
        for (index, imageName) in logoImage.enumerate() {
            let button   = UIButton(type: UIButtonType.Custom) as UIButton
            button.tag = index
            button.frame = CGRectMake(0, 0, 36, 36)
            button.setImage(imageName, forState: .Normal)
            //button.targetForAction(#selector(SettingsVC.sPressed), withSender: self)
            button.addTarget(self, action: #selector(SettingsVC.sPressed), forControlEvents: UIControlEvents.TouchUpInside)
            button.center = CGPointMake(CGFloat(i), 300)
            i+=56
            //button.backgroundColor = UIColor.clearColor()
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.whiteColor().CGColor
            button.clipsToBounds = true
            self.view.addSubview(button)
        }
        
        
    }
    func sPressed(sender: UIButton) {
        for i in 0...4 {
            let tempButton = self.view.viewWithTag(i) as? UIButton
            if tempButton!.tintColor == UIColor.redColor() {
                print("htouwrhgatouswh")
                tempButton!.setImage(logoImage[i], forState: .Normal)
                break
                }
        }
        print("clicked " + String(sender.tag))
        backgroundColor = logoImage[sender.tag]
        let tintedImage = backgroundColor.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        sender.setImage(tintedImage, forState: .Normal)
        sender.tintColor = UIColor.redColor()
        
    }


    @IBAction func closeNotSave(sender: AnyObject) {
        self.removeAnimate()
    }
    @IBAction func closeVC(sender: AnyObject) {
        self.removeAnimate()
        delegate?.adjustDate(dateToggle)
        delegate?.adjustTimer(timerSelection)
        delegate?.adjustBackground(backgroundColor)
    }
    func showAnimate() {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }

    
    
    func removeAnimate() {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            },completion: {(finished : Bool) in
                if (finished) {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func dateOn(sender: AnyObject) {
        on.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        offDate.setTitleColor(UIColor.grayColor(), forState: .Normal)
        dateToggle = true
    }
    
    @IBAction func dateOff(sender: AnyObject) {
        offDate.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        on.setTitleColor(UIColor.grayColor(), forState: .Normal)
        dateToggle = false
    }
    
    
    //MARK: Notification Setup
    var timerSelection = 0
    @IBOutlet weak var offNotif: UIButton!
    @IBAction func offNotif(sender: AnyObject) {
        offNotif.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        resetButton()
        timerSelection = 0
    }
    @IBOutlet weak var quarterHr: UIButton!
    @IBAction func quarterHr(sender: AnyObject) {
        quarterHr.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        resetButton()
        timerSelection = 1
    }
    @IBOutlet weak var oneHr: UIButton!
    @IBAction func oneHr(sender: AnyObject) {
        oneHr.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        resetButton()
        timerSelection = 2
    }
    @IBOutlet weak var fiveHr: UIButton!
    @IBAction func fiveHr(sender: AnyObject) {
        fiveHr.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        resetButton()
        timerSelection = 3
    }
    @IBOutlet weak var tenHr: UIButton!
    @IBAction func tenHr(sender: AnyObject) {
        tenHr.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        resetButton()
        timerSelection = 4
    }
    
    func resetButton() {
        switch timerSelection {
        case 0:
            offNotif.setTitleColor(UIColor.grayColor(), forState: .Normal)
        case 1:
            quarterHr.setTitleColor(UIColor.grayColor(), forState: .Normal)
        case 2:
            oneHr.setTitleColor(UIColor.grayColor(), forState: .Normal)
        case 3:
            fiveHr.setTitleColor(UIColor.grayColor(), forState: .Normal)
        case 4:
            tenHr.setTitleColor(UIColor.grayColor(), forState: .Normal)
        default:
            timerSelection = 0
            resetButton()
        }
    }
    
}




















