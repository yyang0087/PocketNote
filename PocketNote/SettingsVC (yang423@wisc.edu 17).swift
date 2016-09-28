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
    var backgroundColor = "paper.jpg"
    @IBOutlet weak var fg: UIView!
    @IBOutlet weak var on: UIButton!
    @IBOutlet weak var offDate: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let overlayView = UIView(frame: CGRectMake(0,0,600,600))
        overlayView.center = self.view.center
        overlayView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(overlayView)
        
        overlayView.addSubview(fg)
        
        
        
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        self.showAnimate()
        if dateToggle {
            on.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        }
        else {
            offDate.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        }
        
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
        
        
        
       
        var maskLayer = CAShapeLayer()
        let path = CGPathCreateWithRect(CGRectMake(150,100,300,400), nil)
        maskLayer.path = path
        
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        // Release the path since it's not covered by ARC.
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        //overlayView.layer.addSublayer(maskLayer)
        //overlayView.layer.removeFromSuperlayer()
        
        
        
        
        let myGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.closeVC(_:)))
        //overlayView.addGestureRecognizer(myGesture)
        
        
        
    }

    @IBAction func closeVC(sender: AnyObject) {
        print("closepoipup")
        self.removeAnimate()
        
        
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
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.adjustDate(dateToggle)
        delegate?.adjustTimer(timerSelection)
        delegate?.adjustBackground(backgroundColor)
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




















