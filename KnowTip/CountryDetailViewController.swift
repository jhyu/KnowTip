//
//  CountryDetailViewController.swift
//  KnowTip
//
//  Created by Jason Yu on 5/21/15.
//  Copyright (c) 2015 Jason Yu. All rights reserved.
//

import UIKit
import Social
import pop

class CountryDetailViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var porterLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var taxiLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var country : NSString?
    var countryImage : NSString?
    
    var taxiTip : NSString?
    var porterTip : NSString?
    var restaurantTip : NSString?
    
    @IBOutlet weak var shareFacebook: UIButton!
    @IBOutlet weak var shareTwitter: UIButton!
    
    @IBAction func editAction(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Something not quite right?", message: "Suggest an edit.", preferredStyle: .Alert)
        
        
        let oneAction = UIAlertAction(title: "Contact us", style: .Default) { (_) in
            //Amplitude.logEvent("Contact KnowTip")
            
            let toEmail = "jason@jasonyu.co"
            let subject = "KnowTip: Edit request for \(self.country!)"
            var email = "mailto:\(toEmail)?subject=\(subject)"
            email = email.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            UIApplication.sharedApplication().openURL(NSURL(string: email)!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addAction(oneAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
        }
        
    }
    
    override func shouldAutorotate() -> Bool {
        if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.Unknown) {
                return false;
        }
        else {
            return true;
        }
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue) | Int(UIInterfaceOrientationMask.PortraitUpsideDown.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.porterLabel.text = "\(porterTip!)"
        self.taxiLabel.text = "\(taxiTip!)"
        self.tipLabel.text = "\(restaurantTip!)"
        
        /*
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anim.fromValue = @(0.0);
        anim.toValue = @(1.0);
        [view pop_addAnimation:anim forKey:@"fade"];
        */
        
    }
    
    @IBAction func twitterAction(sender: AnyObject) {
        var edited = self.country;
        var exceptions = ["United States", "United Arab Emirates", "United Kingdom"]
        if contains(exceptions, self.country! as String) {
            edited = "The \(self.country!)"
        }
        
        let shareText = "In \(edited!), tip \(tipLabel.text!.lowercaseString) at restaurants, \(taxiLabel.text!.lowercaseString) in taxis, and \(porterLabel.text!.lowercaseString) to the bellhop per bag. By @KnowTipApp http://itunes.apple.com/app/id997468314"
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText(shareText)
            self.presentViewController(twitterSheet, animated: true, completion: {/*Amplitude.logEvent("Share Twitter")*/})
        } else {
            //Amplitude.logEvent("Share Twitter Error")
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func facebookAction(sender: AnyObject) {
        var edited = self.country;
        var exceptions = ["United States", "United Arab Emirates", "United Kingdom"]
        if contains(exceptions, self.country! as String) {
            edited = "The \(self.country!)"
        }
        let shareText = "In \(edited!), tip \(tipLabel.text!.lowercaseString) at restaurants, \(taxiLabel.text!.lowercaseString) in taxis, and \(porterLabel.text!.lowercaseString) to the bellhop per bag. By @KnowTipApp http://itunes.apple.com/app/id997468314"
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText(shareText)
            self.presentViewController(facebookSheet, animated: true, completion: {/*Amplitude.logEvent("Share Facebook")}*/})
        } else {
            //Amplitude.logEvent("Share Facebook Error")
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let spring = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
        spring.toValue = self.view.frame.size.height - 40
        spring.springBounciness = 10 // a float between 0 and 20
        spring.springSpeed = 15

        
        self.shareFacebook.pop_addAnimation(spring, forKey: "fadeFB")
        self.shareTwitter.pop_addAnimation(spring, forKey: "fadeTwitter")
        
        //let anim = POPBasicAnimation(propertyNamed: kCAMediaTimingFunctionEaseInEaseOut)
        //anim.fromValue = 0.0
        //anim.toValue = 1.0
        
        
        let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
        anim.fromValue = -50
        anim.toValue = 75
        anim.springBounciness = 10 // a float between 0 and 20
        anim.springSpeed = 15
        self.countryLabel.text = "\(country!)"
        self.countryLabel.pop_addAnimation(anim, forKey: "fade")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.countryLabel.alpha = 0.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.countryLabel.alpha = 1.0
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        let rect : CGRect = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height)
        var vista = UIView(frame: rect)
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = vista.bounds
        
        let cor1 = UIColor(red: 215/256.0, green: 0/256.0, blue: 96/256.0, alpha: 1.0).CGColor
        let cor2 = UIColor(red: 229/256.0, green: 64/256.0, blue: 40/256.0, alpha: 1.0).CGColor
        let arrayColors = [cor1, cor2]
        
        gradient.colors = arrayColors
        self.view.layer.insertSublayer(gradient, atIndex: 0)
        
        self.imageview.image = UIImage(named: "\(countryImage!)")
        self.imageview.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageview.clipsToBounds = true

        self.shareFacebook.setBackgroundImage(UIImage(named:"Facebook-128.png"), forState: UIControlState.Normal)
        self.shareTwitter.setBackgroundImage(UIImage(named:"Twitter-Bird-128.png"), forState: UIControlState.Normal)
        print("the country image is \(countryImage!)")
        //self.backButton.setTitle("\(country!)", forState: UIControlState.Normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender: AnyObject) {
        UIApplication.sharedApplication().statusBarStyle = .Default

        self.dismissViewControllerAnimated(true, completion: {});
        self.shareTwitter.pop_removeAnimationForKey("fadeFB")
        self.shareTwitter.pop_removeAnimationForKey("fadeTwitter")
        self.countryLabel.pop_removeAnimationForKey("fade")

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
