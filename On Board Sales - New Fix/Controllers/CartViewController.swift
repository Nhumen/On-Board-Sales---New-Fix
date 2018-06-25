//
//  CartViewController.swift
//  On Board Sales - New Fix
//
//  Created by Michael Baaske on 10.06.18.
//  Copyright © 2018 Michael Baaske. All rights reserved.
//

import UIKit
import RealmSwift


class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var inCartItems : [String] = []
    var inCartPrice: [Double] = []
    var inCartUnderscore : [String] = []
    var paidCarts: [Double] = []
    
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartEndPriceLabel: UILabel!
    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToSales", sender: self)
    }
    @IBAction func forwardTapped(_ sender: Any) {
        performSegue(withIdentifier: "toDailySalesSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return inCartItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)
        let newItem = ItemsInCart()
        
        cell.textLabel?.text = String(inCartItems[indexPath.row])
        newItem.item = inCartItems[indexPath.row]
        cell.detailTextLabel?.text = "€\(String(format: "%.2f",inCartPrice[indexPath.row]))"
        newItem.price = inCartPrice[indexPath.row]
        save(item: newItem)

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
            let newPaidCart = DailySales()
            paidCarts.append(sum)
            newPaidCart.paidCarts = sum
            inCartItems.removeAll()
            inCartPrice.removeAll()
            save(sales: newPaidCart)
            delete()
            performSegue(withIdentifier: "backToSales", sender: self)
        }
    }
    
    @IBAction func dailyButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toDailySalesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SalesViewController {
            destinationViewController.inCartItems = inCartItems
            destinationViewController.inCartPrice = inCartPrice
        }
    }
    
    func save(item: ItemsInCart) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("\(error)")
        }
    }
    func save(sales: DailySales) {
        do {
            try realm.write {
                realm.add(sales)
            }
        } catch {
            print("\(error)")
        }
    }
    func delete() {
        let deletable = realm.objects(ItemsInCart.self)
        do {
            try realm.write {
                realm.delete(deletable)
            }
        } catch {
            print("\(error)")
        }
    }
    
}
