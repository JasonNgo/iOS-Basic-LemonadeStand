//
//  Factory.swift
//  Lemonade Stand
//
//  Created by Jason Ngo on 2014-10-17.
//  Copyright (c) 2014 Jason Ngo. All rights reserved.
//

import Foundation

class Factory {
    class func createCustomers() -> [Customer] {
        var weather = Weather.predictWeather()
        
        var customers:[Customer] = []
        var customerLimit:Int
        
        if (weather == "Cold") {
            customerLimit = Int(arc4random_uniform(UInt32(2)) + 1)
        } else if (weather == "Warm") {
            customerLimit = Int(arc4random_uniform(UInt32(8)) + 1)
        } else {
            customerLimit = Int(arc4random_uniform(UInt32(5)) + 1)
        }
        
        for (var i = 1; i <= customerLimit; i++) {
            var randomNumber = Float(Int(arc4random_uniform(UInt32(100)) + 1)) / 100
            
            var customer = Customer(tastePreference: randomNumber, willPay: false)
            customers.append(customer)
        }
        
        return customers
    }
}