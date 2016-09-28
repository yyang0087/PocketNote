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

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimate()
        
        if dateToggle {
            on.setTitleColor(UIColor.orange, for: UIControlState())
        }
        else {
            offDate.setTitleColor(UIColor.orange, for: UIControlState())
        }
        print(timerSelection)
        if timerSelection == 0 {
            offNotif.setTitleColor(UIColor.orange, for: UIControlState())
        }
        else if timerSelection == 1 {
            quarterHr.setTitleColor(UIColor.orange, for: UIControlState())
        }
        else if timerSelection == 2 {
            oneHr.setTitleColor(UIColor.orange, for: UIControlState())
        }
        else if timerSelection == 3 {
            fiveHr.setTitleColor(UIColor.orange, for: UIControlState())
        }
        else if timerSelection == 4 {
            tenHr.setTitleColor(UIColor.orange, for: UIControlState())
        }
        
        var i = (UIScreen.main.bounds.width - fg.frame.width)/2 + 38
        for (index, imageName) in logoImage.enumerated() {
            let button   = UIButton(type: UIButtonType.custom) as UIButton
            button.tag = index
            button.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
            button.setImage(imageName, for: UIControlState())
            //button.targetForAction(#selector(SettingsVC.sPressed), withSender: self)
            button.addTarget(self, action: #selector(SettingsVC.sPressed), for: UIControlEvents.touchUpInside)
            button.center = CGPoint(x: CGFloat(i), y: 300)
            i+=56
            //button.backgroundColor = UIColor.clearColor()
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.clipsToBounds = true
            self.view.addSubview(button)
        }
        
        
    }
    func sPressed(_ sender: UIButton) {
        /**for i in 0...4 {
            let tempButton = self.view.viewWithTag(i) as? UIButton
            if tempButton?.tintColor == UIColor.redColor() {
                print("htouwrhgatouswh")
                tempButton!.setImage(logoImage[i], forState: .Normal)
                break
                }
        }*/
        print("clicked " + String(sender.tag))
        backgroundColor = logoImage[sender.tag]
        /**let tintedImage = backgroundColor.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        sender.setImage(tintedImage, forState: .Normal)
        sender.tintColor = UIColor.redColor()
       */
    }


    @IBAction func closeNotSave(_ sender: AnyObject) {
        self.removeAnimate()
    }
    @IBAction func closeVC(_ sender: AnyObject) {
        self.removeAnimate()
        delegate?.adjustDate(dateToggle)
        delegate?.adjustTimer(timerSelection)
        delegate?.adjustBackground(backgroundColor)
    }
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }

    
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            },completion: {(finished : Bool) in
                if (finished) {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func dateOn(_ sender: AnyObject) {
        on.setTitleColor(UIColor.orange, for: UIControlState())
        offDate.setTitleColor(UIColor.gray, for: UIControlState())
        dateToggle = true
    }
    
    @IBAction func dateOff(_ sender: AnyObject) {
        offDate.setTitleColor(UIColor.orange, for: UIControlState())
        on.setTitleColor(UIColor.gray, for: UIControlState())
        dateToggle = false
    }
    
    
    //MARK: Notification Setup
    var timerSelection = 0
    @IBOutlet weak var offNotif: UIButton!
    @IBAction func offNotif(_ sender: AnyObject) {
        offNotif.setTitleColor(UIColor.orange, for: UIControlState())
        resetButton()
        timerSelection = 0
    }
    @IBOutlet weak var quarterHr: UIButton!
    @IBAction func quarterHr(_ sender: AnyObject) {
        quarterHr.setTitleColor(UIColor.orange, for: UIControlState())
        resetButton()
        timerSelection = 1
    }
    @IBOutlet weak var oneHr: UIButton!
    @IBAction func oneHr(_ sender: AnyObject) {
        oneHr.setTitleColor(UIColor.orange, for: UIControlState())
        resetButton()
        timerSelection = 2
    }
    @IBOutlet weak var fiveHr: UIButton!
    @IBAction func fiveHr(_ sender: AnyObject) {
        fiveHr.setTitleColor(UIColor.orange, for: UIControlState())
        resetButton()
        timerSelection = 3
    }
    @IBOutlet weak var tenHr: UIButton!
    @IBAction func tenHr(_ sender: AnyObject) {
        tenHr.setTitleColor(UIColor.orange, for: UIControlState())
        resetButton()
        timerSelection = 4
    }
    
    func resetButton() {
        switch timerSelection {
        case 0:
            offNotif.setTitleColor(UIColor.gray, for: UIControlState())
        case 1:
            quarterHr.setTitleColor(UIColor.gray, for: UIControlState())
        case 2:
            oneHr.setTitleColor(UIColor.gray, for: UIControlState())
        case 3:
            fiveHr.setTitleColor(UIColor.gray, for: UIControlState())
        case 4:
            tenHr.setTitleColor(UIColor.gray, for: UIControlState())
        default:
            timerSelection = 0
            resetButton()
        }
    }
    
}




















