//
//  ItemsInCart.swift
//  On Board Sales - New Fix
//
//  Created by Michael Baaske on 15.06.18.
//  Copyright © 2018 Michael Baaske. All rights reserved.
//

import Foundation
import RealmSwift

class ItemsInCart: Object {
    
    @objc dynamic var item: String = ""
    @objc dynamic var price: Double = 0
    
}
