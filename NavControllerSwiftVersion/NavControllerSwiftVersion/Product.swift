//
//  Product.swift
//  NavControllerSwiftVersion
//
//  Created by Aditya Narayan on 11/18/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

import UIKit

class Product: NSObject {
   
    var name: String
    var image: String
    var url: String
    var companyID: Int
    
    init(name: String, image: String, url: String, companyID: Int) {
        self.name = name
        self.image = image
        self.url = url
        self.companyID = companyID
    }
    
}
