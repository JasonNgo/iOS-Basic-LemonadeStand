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
    
    // Quantities
    var money:Int = 10 // Starting: 10
    var lemons:Int = 1 // Starting: 1
    var iceCubes:Int = 1 //Starting: 1
    
    var lemonCount:Int = 0
    var iceCubeCount:Int = 0
    
    var lemonRatio:Int = 1
    var iceCubeRatio:Int = 0
    
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
        if (lemons > 1) {
            money += 2
            lemons -= 1
            lemonCount -= 1
        } else {
            showAlerts(header: "Insufficient Lemons!", message: "You must have at least 1 lemon")
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
        if (iceCubes > 0) {
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
        if (iceCubeRatio > 0) {
            iceCubeRatio -= 1
        }
        updateView()
    }
    
    @IBAction func sellingBtnPressed(sender: UIButton) {
    }
    
    func calculateRatio(lemonRatio:Int, iceCubeRatio:Int) -> Float {
        return Float(lemonRatio) / Float(iceCubeRatio)
    }
    
    func showAlerts(header:String = "Warning", message:String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

