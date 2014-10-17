//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by Jason Ngo on 2014-10-16.
//  Copyright (c) 2014 Jason Ngo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Labels
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var lblLemons: UILabel!
    @IBOutlet weak var lblIceCubes: UILabel!
    @IBOutlet weak var lblPurchaseLemons: UILabel!
    @IBOutlet weak var lblPurchaseIceCubes: UILabel!
    @IBOutlet weak var lblMixLemons: UILabel!
    @IBOutlet weak var lblMixIceCubes: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    
    // Quantities
    var money:Int = 10 // Starting: 10
    var lemons:Int = 1 // Starting: 1
    var iceCubes:Int = 1 //Starting: 1
    
    var lemonCount:Int = 0
    var iceCubeCount:Int = 0
    
    var lemonRatio:Int = 1
    var iceCubeRatio:Int = 1
    
    var lemonToIceRatio:Float = 0.0
    var customers:[Customer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateView() {
        lblMoney.text = "$ \(money)"
        
        // Formating for (s)
        if (lemons > 1) {
            lblLemons.text = "\(lemons) Lemons"
        } else {
            lblLemons.text = "\(lemons) Lemon"
        }
        if (iceCubes > 1) {
            lblIceCubes.text = "\(iceCubes) Ice Cubes"
        } else {
            lblIceCubes.text = "\(iceCubes) Ice Cube"
        }
        
        lblPurchaseLemons.text = "\(lemonCount)"
        lblPurchaseIceCubes.text = "\(iceCubeCount)"
        lblMixLemons.text = "\(lemonRatio)"
        lblMixIceCubes.text = "\(iceCubeRatio)"
    }

    @IBAction func purchaseLemonsIsPressed(sender: UIButton) {
        if (money > 1) {
            money -= 2
            lemons += 1
            lemonCount += 1
        } else {
            showAlerts(header: "Insufficient Funds!", message: "You don't have enough money to purchase any more lemons")
        }
        updateView()
    }

    @IBAction func sellLemonsIsPressed(sender: UIButton) {
        if (lemons > 0) && (lemonCount > 0) {
            money += 2
            lemons -= 1
            lemonCount -= 1
        } else {
            showAlerts(header: "Insufficient Lemons!", message: "")
        }
        updateView()
    }
    
    @IBAction func purchaseIceCubesIsPressed(sender: UIButton) {
        if (money > 0) {
            money -= 1
            iceCubes += 1
            iceCubeCount += 1
        } else {
            showAlerts(header: "Insufficient Funds!", message: "You don't have enough money to purchase any more ice cubes")
        }
        updateView()
    }
    
    @IBAction func sellIceCubsIsPressed(sender: UIButton) {
        if (iceCubes > 0) && (iceCubeCount > 0) {
            iceCubes -= 1
            iceCubeCount -= 1
            money += 1
        } else {
            showAlerts(header: "Insufficient Ice Cubes!", message: "")
        }
        updateView()
    }
    
    @IBAction func mixLemonsIsPressed(sender: UIButton) {
        if (lemonRatio < lemons) {
            lemonRatio += 1
        } else {
            showAlerts(header: "Insufficient Lemons!", message: "Cannot add any more lemons")
        }
        updateView()
    }
    
    @IBAction func unmixLemonsIsPressed(sender: UIButton) {
        if (lemonRatio > 1) {
            lemonRatio -= 1
        } else {
            showAlerts(header: "Lemonade?", message: "You need to have at least one lemon to make lemonade!")
        }
        updateView()
    }
    
    @IBAction func mixIceCubesIsPressed(sender: UIButton) {
        if (iceCubeRatio < iceCubes) {
            iceCubeRatio += 1
        } else {
            showAlerts(header: "Insufficient Ice Cubes", message: "Cannot add any more ice cubes")
        }
        updateView()
    }
    
    @IBAction func unmixIceCubesIsPressed(sender: UIButton) {
        if (iceCubeRatio > 1) {
            iceCubeRatio -= 1
        } else {
            showAlerts(header: "No Ice?", message: "You need to have at least one ice cube")
        }
        updateView()
    }
    
    @IBAction func sellingBtnPressed(sender: UIButton) {
        if ((money >= 0) && (lemons > 0) && (iceCubes > 0)) {
            customers = Factory.createCustomers()
            if (Weather.predictWeather() == "Warm") {
                imgWeather.image = UIImage(named: "Warm")
            } else if (Weather.predictWeather() == "Cold") {
                imgWeather.image = UIImage(named: "Cold")
            } else {
                imgWeather.image = UIImage(named: "Mild")
            }
            gettingPaid(customers)
            for (index, customer) in enumerate(customers) {
                println("Customer \(index + 1): Taste Preference: \(customer.tastePreference) Paid: \(customer.willPay)")
                if (customer.willPay) {
                    money += 2
                }
            }
            resetState()
            updateView()
        } else {
            showAlerts(header: "Game Over", message: "You have run out of funds!")
        }
    }
    
    func resetState() {
        lemons = lemons - lemonRatio
        iceCubes = iceCubes - iceCubeRatio
        
        iceCubeRatio = 1
        iceCubeCount = 0
        
        lemonRatio = 1
        lemonCount = 0
    }
    
    func calculateTaste(lemonRatio:Int, iceCubeRatio:Int) -> String {
        lemonToIceRatio = Float(lemonRatio) / Float(iceCubeRatio)
        
        if (lemonToIceRatio < 0.4) {
            return "Diluted Lemonade"
        } else if (lemonToIceRatio >= 0.4) && (lemonToIceRatio < 0.6) {
            return "Equal Lemonade"
        } else {
            return "Acidic Lemonade"
        }
    }
    
    func gettingPaid(customers:[Customer]) {
        var taste = calculateTaste(lemonRatio, iceCubeRatio: iceCubeRatio)
        println("Taste: \(taste)")
        for customer in customers {
            switch taste {
            case "Diluted Lemonade":
                if (customer.tastePreference >= 0 && customer.tastePreference < 0.4) {
                    customer.willPay = true
                }
            case "Equal Lemonade":
                if (customer.tastePreference >= 0.4 && customer.tastePreference < 0.6) {
                    customer.willPay = true
                }
            case "Acidic Lemonade":
                if (customer.tastePreference >= 0.6 && customer.tastePreference <= 1) {
                    customer.willPay = true
                }
            default:
                customer.willPay = false
            }
        }
    }
    
    func showAlerts(header:String = "Warning", message:String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

