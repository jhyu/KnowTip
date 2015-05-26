//
//  InterfaceController.swift
//  KnowTip WatchKit Extension
//
//  Created by Jason Yu on 5/24/15.
//  Copyright (c) 2015 Jason Yu. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var countryTable: WKInterfaceTable!
    
    let countries = CountryDataSource().countries
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        loadTableData()
    }
    
    private func loadTableData() {
        countryTable.setNumberOfRows(countries.count, withRowType: "CountryTableRowController")
        
        for (index, countryName) in enumerate(countries) {
            
            let row = countryTable.rowControllerAtIndex(index) as! CountryTableRowController
            
            row.countryLabel.setText(countryName)
            
        }
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject?
    {
        
        let countryName = countries[rowIndex]
        return countryName
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
