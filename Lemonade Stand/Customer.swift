//
//  Customer.swift
//  Lemonade Stand
//
//  Created by Jason Ngo on 2014-10-17.
//  Copyright (c) 2014 Jason Ngo. All rights reserved.
//

import Foundation

class Customer {
    var tastePreference:Float
    var willPay:Bool
    
    init (tastePreference:Float, willPay:Bool) {
        self.tastePreference = tastePreference
        self.willPay = willPay
    }
}