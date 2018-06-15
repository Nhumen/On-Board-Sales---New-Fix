//
//  DailySalesViewController.swift
//  On Board Sales - New Fix
//
//  Created by Michael Baaske on 10.06.18.
//  Copyright © 2018 Michael Baaske. All rights reserved.
//

import UIKit

class DailySalesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var paidItems : [Double] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var takingsLabel: UILabel!
    
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        let sum = paidItems.reduce(0, {$0 + $1})
        takingsLabel.text = "€\(String(format: "%.2f", sum))"
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return paidItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailySalesCell", for: indexPath)
        
        cell.textLabel?.text = "Sale no. \(indexPath.row + 1)"
        cell.detailTextLabel?.text = "€\(String(format: "%.2f",paidItems[indexPath.row]))"
        
        return cell
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endShiftTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "endShiftSegue", sender: self)
    }


}
