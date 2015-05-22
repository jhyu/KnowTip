//
//  ViewController.swift
//  KnowTip
//
//  Created by Jason Yu on 5/20/15.
//  Copyright (c) 2015 Jason Yu. All rights reserved.
//

import UIKit
import QuartzCore
//import pop

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var sortedCountries = [String]()
    var selectedCountry : NSString? = ""
    var allCountries = [Country]()

    
    let countries = ["Argentina", "Australia", "Austria", "Bahamas", "Belgium", "Brazil", "Brunei", "Bulgaria", "Canada", "Cayman Islands", "Chile", "China", "Colombia", "Costa Rica", "Denmark", "Ecuador", "Egypt", "Estonia", "Fiji", "Finland", "France", "Germany", "Greece", "Hong Kong", "Hungary", "India", "Indonesia", "Ireland", "Israel", "Italy", "Japan", "Malaysia", "Mexico", "Morocco", "Netherlands", "New Zealand", "Norway", "Oman", "Peru", "Philippines", "Poland", "Portugal", "Romania", "Russia", "Samoa", "Saudi Arabia", "Singapore", "South Africa", "South Korea", "Spain", "Switzerland", "Taiwan", "Tanzania", "Thailand", "Turkey", "United Arab Emirates", "United Kingdom", "United States", "Venezuela", "Vietnam"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.title = "Select a country";
        
        var infoButton = UIButton.buttonWithType(UIButtonType.InfoLight) as! UIButton
        infoButton.addTarget(self, action: "infoAction", forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton as UIView)
        
        self.sortedCountries = countries.sorted({$0 < $1});
        
        self.tableView.layoutIfNeeded()
        //self.navigationItem.title = "The title";
        
        let tableViewSize: CGSize = self.tableView.contentSize
        let rect : CGRect = CGRectMake(0,0,tableViewSize.width, tableViewSize.height)
        var vista = UIView(frame: rect)
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = vista.bounds
        
        let cor1 = UIColor(red: 215/256.0, green: 0/256.0, blue: 96/256.0, alpha: 1.0).CGColor
        let cor2 = UIColor(red: 229/256.0, green: 64/256.0, blue: 40/256.0, alpha: 1.0).CGColor
        let arrayColors = [cor1, cor2]
        
        gradient.colors = arrayColors
        self.tableView.layer.insertSublayer(gradient, atIndex: 0)
        self.tableView.backgroundColor =  UIColor(red: 215/256.0, green: 0/256.0, blue: 96/256.0, alpha: 1.0)

        /*
        RestApiManager.sharedInstance.getRandomUser { json in
            let results = json["results"]
            //println(results)
            for (index: String, subJson: JSON) in results {
                let description: AnyObject = subJson["primaryGenreName"].object
                println(description)
            }
        }*/
    }
    
    func infoAction() {
        
        let alertController = UIAlertController(title: "KnowTip", message: "Version One", preferredStyle: .Alert)

        let oneAction = UIAlertAction(title: "Rate KnowTip", style: .Default) { (_) in
            //Amplitude.logEvent("Rate KnowTip")
            if let checkURL = NSURL(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=997468314&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8") {
                if UIApplication.sharedApplication().openURL(checkURL) {
                    println("url sucefully opened")
                }
            } else {
                println("invalid url")
            }
        }
        
        let twoAction = UIAlertAction(title: "Contact us", style: .Default) { (_) in
            //Amplitude.logEvent("Contact KnowTip")

            let email = "jason@jasonyu.co"
            let url = NSURL(string: "mailto:\(email)")
            UIApplication.sharedApplication().openURL(url!)
        }
        
        let threeAction = UIAlertAction(title: "Spread the word", style: .Default) { (_) in
            
            let textToShare = "Check out the KnowTip app to help you figure out how much to tip different countries!"
            
            //
            if let myWebsite = NSURL(string: "http://itunes.apple.com/app/id997468314")
            {
                let objectsToShare = [textToShare, myWebsite]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                self.presentViewController(activityVC, animated: true, completion: { /*Amplitude.logEvent("Share KnowTip") */})
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addAction(oneAction)
        alertController.addAction(twoAction)
        alertController.addAction(threeAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
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
    
    /*
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, 40))
        let headerTitle = UILabel(frame: CGRectMake(15, 0, self.tableView.frame.size.width-15, 40))
        headerTitle.text = "Select a country"
        headerTitle.font = UIFont(name: "HelveticaNeue", size: 24.0)
        headerTitle.textColor = UIColor.whiteColor()
        headerCell.backgroundColor = UIColor(red: 229/256.0, green: 64/256.0, blue: 40/256.0, alpha: 1.0)
        headerCell.insertSubview(headerTitle, atIndex:0)
        return headerCell
    }*/
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedCountries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 18.0)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = self.sortedCountries[indexPath.row]
        
        return cell
    }
        
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectedCountry = self.sortedCountries[indexPath.row]
        self.performSegueWithIdentifier("showCountry", sender: self)
        
       //let params = ["Country" : self.selectedCountry]
        //Amplitude.logEvent("showCountry", withEventProperties:params)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showCountry") {
            let viewController:CountryDetailViewController = segue.destinationViewController as! CountryDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            viewController.country = self.selectedCountry
            let trimmedString = self.selectedCountry!.stringByReplacingOccurrencesOfString(" ", withString:"")
            viewController.countryImage = NSString(format: "%@.jpg", trimmedString.lowercaseString)
            
            let theCountry = Country.countryWithName(self.selectedCountry! as String)
            viewController.porterTip = theCountry!.porterTip
            viewController.taxiTip = theCountry!.taxiTip
            viewController.restaurantTip = theCountry!.restaurantTip
            
            //viewController.porterTip = self.countryDict["Porter"]![self.selectedIndex!.row]
            //viewController.taxiTip = self.countryDict["Taxi"]![self.selectedIndex!.row]
            //viewController.restaurantTip = self.countryDict["Restaurant"]![self.selectedIndex!.row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


