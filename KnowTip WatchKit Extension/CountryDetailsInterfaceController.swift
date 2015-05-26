//
//  CountryDetailsInterfaceController.swift
//  KnowTip
//
//  Created by Jason Yu on 5/24/15.
//  Copyright (c) 2015 Jason Yu. All rights reserved.
//

import WatchKit
import Foundation


class CountryDetailsInterfaceController: WKInterfaceController {
    
    
    @IBOutlet weak var tableView: WKInterfaceTable!
    @IBOutlet weak var countryLabel: WKInterfaceLabel!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let countryName = context as? String {
            countryLabel.setText(countryName)
            print("the country name is \(countryName)")

            let selectedCountry = Country.countryWithName(countryName)
            
            print("the selected country is \(selectedCountry)")
            tableView.setNumberOfRows(3, withRowType: "CountryDetailsTableRowController")
            
            let restaurantTip = tableView.rowControllerAtIndex(0) as! CountryDetailsTableRowController
            restaurantTip.tipAmount.setText(selectedCountry?.restaurantTip)
            restaurantTip.tipType.setText("Restaurant")

            
            let taxiRow = tableView.rowControllerAtIndex(1) as! CountryDetailsTableRowController
            taxiRow.tipAmount.setText(selectedCountry?.taxiTip)
            taxiRow.tipType.setText("Taxi")
            
            let porterRow = tableView.rowControllerAtIndex(2) as! CountryDetailsTableRowController
            porterRow.tipAmount.setText(selectedCountry?.porterTip)
            porterRow.tipType.setText("Porter")
            
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
