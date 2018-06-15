//
//  CartViewController.swift
//  On Board Sales - New Fix
//
//  Created by Michael Baaske on 10.06.18.
//  Copyright © 2018 Michael Baaske. All rights reserved.
//

import UIKit


class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var inCartItems: [String] = []
    var inCartPrice: [Double] = []
    var inCartUnderscore : [String] = []
    var paidItems: [Double] = []
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartEndPriceLabel: UILabel!
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func forwardTapped(_ sender: Any) {
        performSegue(withIdentifier: "toDailySalesSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return inCartItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)
        
        cell.textLabel?.text = String(inCartItems[indexPath.row])
        cell.detailTextLabel?.text = "€\(String(format: "%.2f",inCartPrice[indexPath.row]))"

        return cell

    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let sum = inCartPrice.reduce(0, {$0 + $1})
        cartEndPriceLabel.text = "€\(String(format: "%.2f", sum))"
        
        
    }
    
    
    @IBAction func paidButtonTapped(_ sender: UIButton) {
        if cartEndPriceLabel.text != "" {
            let sum = inCartPrice.reduce(0, {$0 + $1})
            paidItems.append(sum)
            inCartItems.removeAll()
            inCartPrice.removeAll()
            performSegue(withIdentifier: "backToSales", sender: self)
        }
    }
    
    @IBAction func dailyButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toDailySalesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SalesViewController {
            destinationViewController.inCartItems = inCartItems
            destinationViewController.inCartPrice = inCartPrice
        }
        let paidItems = self.paidItems
        if let destinationViewController = segue.destination as? DailySalesViewController {
            destinationViewController.paidItems = paidItems
        }
    }
    
    
    
}
