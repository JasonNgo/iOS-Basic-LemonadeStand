//
//  Weather.swift
//  Lemonade Stand
//
//  Created by Jason Ngo on 2014-10-17.
//  Copyright (c) 2014 Jason Ngo. All rights reserved.
//

import Foundation
import UIKit

class Weather {
    
    class func predictWeather () -> String {
        var randomNumber = Int(arc4random_uniform(UInt32(3)))
        var weather:String
        switch randomNumber {
        case 0:
            weather = "Cold"
        case 1:
            weather = "Mild"
        case 2:
            weather = "Warm"
        default:
            weather = "Warm"
        }
        return weather
    }
}