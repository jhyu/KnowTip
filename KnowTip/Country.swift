//
//  Country.swift
//  KnowTip
//
//  Created by Jason Yu on 5/22/15.
//  Copyright (c) 2015 Jason Yu. All rights reserved.
//

// Country class
class Country {
    
    let name: String
    let porterTip: String
    let taxiTip: String
    let restaurantTip : String
    
    class func allCountries() -> [Country] {
        var countries = [Country]()
        
        let countryDict = [
            "Country":["Argentina","Australia","Austria","Bahamas","Belgium","Brazil","Brunei","Bulgaria","Canada","Cayman Islands","Chile","China","Colombia","Costa Rica","Denmark","Ecuador","Egypt","Estonia","Fiji","Finland","France","Germany","Greece","Hong Kong","Hungary","India","Indonesia","Ireland","Israel","Italy","Japan","Malaysia","Mexico","Morocco","Netherlands","New Zealand","Norway","Oman","Peru","Philippines","Poland","Portugal","Romania","Russia","Samoa","Saudi Arabia","Singapore","South Africa","South Korea","Spain","Switzerland","Taiwan","Tanzania","Thailand","Turkey","United Arab Emirates","United Kingdom","United States","Venezula","Vietnam"],
            "Taxi":["Round up","Round up","Round up","15%","Round up","10%","No tip","Round up","10%","10%","No tip","No tip","No tip","Round up","Round up","Round up","Round up","No tip","Round up","Round up","Round up","Round up","Round up","Round up","Round up","Round up","Round up","Round up","Round up","Round up","No tip","No tip","No tip","Round up","Round up","No tip","Round up","No tip","No tip","Round up","Round up","Round up","Round up","Round up","No tip","10%","No tip","10%","No tip","No tip","Round up","No tip","No tip","No tip","Round up","No tip","10%","10-15%","10%","No tip"],
            "Porter":["$1","$1","$1","$1","$1","$1","No tip","$1","$1","$1","$1","No tip","$1","$1","$1","$1","$1","No tip","No tip","No tip","$1","$1","$1","$1","$1","$1","$0.50","$1","$1","$1","No tip","No tip","$1","$0.50","$1","No tip","$1","No tip","$0.75","$0.50","$1","$1","$1","$1","No tip","$1","No tip","$0.50","No tip","No tip","$1","$1","No tip","No tip","$1","No tip","$1","$1","$0.75","No tip"],
            "Restaurant":["10%","10%","No tip","15%","Round up","10-15%","No tip","10%","15-20%","15%","10%","No tip","10%","5-10%","No tip","10%","5-10%","10-15%","No tip","No tip","No tip","No tip","5-10%","No tip","10%","10%","10%","5-10%","10-15%","No tip","No tip","No tip","10-15%","Round up","Round up","No tip","No tip","No tip","10%","10%","No tip","No tip","Round up","10%","No tip","10-15%","No tip","10%","No tip","No tip","No tip","No tip","10%","No tip","Round up","No tip","10%","15-20%","10%","No tip"]
        ]
        
       for var i = 0; i < countryDict["Country"]?.count; ++i {
            countries.append(Country(name: countryDict["Country"]![i], porterTip: countryDict["Porter"]![i], taxiTip: countryDict["Taxi"]![i], restaurantTip: countryDict["Restaurant"]![i]))
        }
        return countries
    }
    
    class func countryWithName(name: String) -> Country? {
        var selectedCountry : Country?
        let countries = allCountries()
        for (var i = 0; i < countries.count; ++i) {
            if (name == countries[i].name) {
                selectedCountry = countries[i]
            }
        }
        print(selectedCountry?.name)
        return selectedCountry
    }
    
    init(name: String, porterTip: String, taxiTip: String, restaurantTip: String) {
        self.name = name
        self.porterTip = porterTip
        self.taxiTip = taxiTip
        self.restaurantTip = restaurantTip
    }
    
}