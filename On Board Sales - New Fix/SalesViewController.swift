//
//  SalesViewController.swift
//  On Board Sales - New Fix
//
//  Created by Michael Baaske on 10.06.18.
//  Copyright © 2018 Michael Baaske. All rights reserved.
//

import UIKit


class SalesViewController: UIViewController {
    
    var inCartItems : [String] = []
    var inCartPrice : [Double] = []
    var inCartUnderscore : [String] = []
    var sum : Double = 0
    
    let itemName = ["Kopfhörer","Capri-Sun","Wine €5.-","Snacks €2.-","Snacks €3.-","Sandwich Last Order"]
    let itemPrice = [3.50,1.00,5.00,2.00,3.00,3.00]
    let dealName = ["Snack Deal","Happy Deal","Tapas Deal","Coffee Deal","Longdrink Deal","Sandwich Deal"]
    let dealPrice = [3.50,5.50,11.00,3.50,6.50,6.50]
    let dealUnderscore = ["Beer & Snack","Sofdrinks & Snack","Tapas & Wine","Coffee & Muffin","Softdrink & Miniature","Sandwich & Softdrink"]

    
    @IBOutlet weak var cartPriceLabel: UILabel!
    
    @IBAction func salesButtonPressed(_ sender: UIButton) {
        
        inCartItems.append(itemName[sender.tag])
        inCartPrice.append(itemPrice[sender.tag])
        updateCartPriceLabel()
        
        print(inCartItems, inCartPrice)
        
    }
    
    
    @IBAction func dealsButtonPressed(_ sender: UIButton) {
        
        inCartItems.append(dealName[sender.tag])
        inCartPrice.append(dealPrice[sender.tag])
        updateCartPriceLabel()
        
        print(inCartItems, inCartPrice)
        
    }
    
    @IBAction func toCartTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toCartSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let inCartItem = inCartItems
        let inCartPrice = self.inCartPrice
        let inCartUnderscore = self.inCartUnderscore
        if let destinationViewController = segue.destination as? CartViewController {
            destinationViewController.inCartItems = inCartItem
            destinationViewController.inCartPrice = inCartPrice
            destinationViewController.inCartUnderscore = inCartUnderscore
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateCartPriceLabel()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCartPriceLabel() {
        let sumInCart = inCartPrice.reduce(0, {$0 + $1})
        let sumSoftdrinks = softdrinksPriceArr.reduce(0, {$0 + $1})
        let sumSnacks = snacksPriceArr.reduce(0, {$0 + $1})
        let sumSandwich = sandwichPriceArr.reduce(0, {$0 + $1})
        let sumBeer = beerPriceArr.reduce(0, {$0 + $1})
        let sumWine6 = wine6PriceArr.reduce(0, {$0 + $1})
        let sumTapas = tapasPriceArr.reduce(0, {$0 + $1})
        let sumCoffee = coffeePriceArr.reduce(0, {$0 + $1})
        let sumMuffin = muffinPriceArr.reduce(0, {$0 + $1})
        let sumMinis = minisPriceArr.reduce(0, {$0 + $1})
        let allSums = (sumInCart + sumSoftdrinks + sumSnacks + sumSandwich + sumBeer + sumWine6 + sumTapas + sumCoffee + sumMuffin + sumMinis)
        cartPriceLabel.text = "€\(String(format: "%.2f", allSums))"
    }
    
    
    var softdrinkArr : [String] = []
    var softdrinksPriceArr : [Double] = []
    var snack150Arr : [String] = []
    var snacksPriceArr : [Double] = []
    var sandwichArr : [String] = []
    var sandwichPriceArr : [Double] = []
    var beerArr : [String] = []
    var beerPriceArr : [Double] = []
    var wine6Arr : [String] = []
    var wine6PriceArr : [Double] = []
    var tapasArr : [String] = []
    var tapasPriceArr : [Double] = []
    var coffeeArr : [String] = []
    var coffeePriceArr : [Double] = []
    var muffinArr : [String] = []
    var muffinPriceArr : [Double] = []
    var minisArr : [String] = []
    var minisPriceArr : [Double] = []
    
    @IBAction func softdrinksTapped(_ sender: UIButton) {
        softdrinkArr.append("Softdrinks")
        softdrinksPriceArr.append(2.50)
        happyDeal()
        sandwichDeal()
        longdrinkDeal()
        updateCartPriceLabel()
    }
    @IBAction func snacks150Tapped(_ sender: UIButton) {
        snack150Arr.append("Snacks €1.50")
        snacksPriceArr.append(1.50)
        happyDeal()
        snackDeal()
        updateCartPriceLabel()
    }
    @IBAction func sandwichTapped(_ sender: UIButton) {
        sandwichArr.append("Softdrinks")
        sandwichPriceArr.append(2.50)
        sandwichDeal()
        updateCartPriceLabel()
    }
    @IBAction func tapasTapped(_ sender: UIButton) {
        tapasArr.append("Softdrinks")
        tapasPriceArr.append(2.50)
        tapasDeal()
        updateCartPriceLabel()
    }
    @IBAction func beerTapped(_ sender: UIButton) {
        beerArr.append("Softdrinks")
        beerPriceArr.append(2.50)
        snackDeal()
        updateCartPriceLabel()
    }
    @IBAction func wine6Tapped(_ sender: UIButton) {
        wine6Arr.append("Softdrinks")
        wine6PriceArr.append(2.50)
        tapasDeal()
        updateCartPriceLabel()
    }
    @IBAction func minisTapped(_ sender: UIButton) {
        minisArr.append("Softdrinks")
        minisPriceArr.append(2.50)
        longdrinkDeal()
        updateCartPriceLabel()
    }
    @IBAction func muffinTapped(_ sender: UIButton) {
        muffinArr.append("Softdrinks")
        muffinPriceArr.append(2.50)
        coffeeDeal()
        updateCartPriceLabel()
    }
    @IBAction func coffeeTapped(_ sender: UIButton) {
        coffeeArr.append("Softdrinks")
        coffeePriceArr.append(2.50)
        coffeeDeal()
        updateCartPriceLabel()
    }
    
    func happyDeal() {
        if softdrinkArr.count >= 2 && snack150Arr.count >= 1 {
            inCartItems.append("Happy Deal")
            inCartPrice.append(5.50)
            softdrinkArr.removeLast()
            softdrinksPriceArr.removeLast()
            softdrinkArr.removeLast()
            softdrinksPriceArr.removeLast()
            snack150Arr.removeLast()
            snacksPriceArr.removeLast()
        }
    }
    
    func sandwichDeal() {
        if softdrinkArr.count >= 1 && sandwichArr.count >= 1 {
            inCartItems.append("Sandwich Deal")
            inCartPrice.append(6.50)
            softdrinkArr.removeLast()
            softdrinksPriceArr.removeLast()
            sandwichArr.removeLast()
            sandwichPriceArr.removeLast()
        }
    }
    
    func snackDeal() {
        if beerArr.count >= 1 && snack150Arr.count >= 1 {
            inCartItems.append("Snack Deal")
            inCartPrice.append(3.50)
            beerArr.removeLast()
            beerPriceArr.removeLast()
            snack150Arr.removeLast()
            snacksPriceArr.removeLast()
        }
    }
    
    func tapasDeal() {
        if tapasArr.count >= 1 && wine6Arr.count >= 1 {
            inCartItems.append("Tapas Deal")
            inCartPrice.append(11.50)
            tapasArr.removeLast()
            tapasPriceArr.removeLast()
            wine6Arr.removeLast()
            wine6PriceArr.removeLast()
        }
    }
    
    func longdrinkDeal() {
        if minisArr.count >= 1 && softdrinkArr.count >= 1 {
            inCartItems.append("Longdrink Deal")
            inCartPrice.append(6.50)
            softdrinkArr.removeLast()
            softdrinksPriceArr.removeLast()
            minisArr.removeLast()
            minisPriceArr.removeLast()
        }
    }
    
    func coffeeDeal() {
        if coffeeArr.count >= 1 && muffinArr.count >= 1 {
            inCartItems.append("Coffee Deal")
            inCartPrice.append(3.50)
            coffeeArr.removeLast()
            coffeePriceArr.removeLast()
            muffinArr.removeLast()
            muffinPriceArr.removeLast()
        }
    }
    
    
}
