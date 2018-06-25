//
//  DailySalesViewController.swift
//  On Board Sales - New Fix
//
//  Created by Michael Baaske on 10.06.18.
//  Copyright © 2018 Michael Baaske. All rights reserved.
//

import UIKit
import RealmSwift

class DailySalesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var paidCarts : [Double] = []
    var dailySales: Results<DailySales>!
    
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var takingsLabel: UILabel!
    
    
    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToCart", sender: self)
    }
    @IBAction func forwardTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backToSales", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        loadPaidCarts()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sum = paidCarts.reduce(0, {$0 + $1})
        takingsLabel.text = "€\(String(format: "%.2f", sum))"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dailySales.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailySalesCell", for: indexPath)
        
        if let dailies = dailySales?[indexPath.row] {
        cell.textLabel?.text = "Sale no. \(indexPath.row + 1)"
        cell.detailTextLabel?.text = "€\(String(format: "%.2f", dailies.paidCarts))"
            let cart = dailies.paidCarts
            paidCarts.append(cart)
        }
//        if let cart = (cell.detailTextLabel?.text), let newCarts = Double(cart) {
//            paidCarts.append(newCarts)
//        }
        
        return cell
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endShiftTapped(_ sender: UIButton) {
        delete()
        performSegue(withIdentifier: "endShiftSegue", sender: self)
    }
    
    func loadPaidCarts() {
        
        dailySales = realm.objects(DailySales.self)
        
    }

    func delete() {
        let deletable = realm.objects(DailySales.self)
        do {
            try realm.write {
                realm.delete(deletable)
            }
        } catch {
            print("\(error)")
        }
    }
    
}
