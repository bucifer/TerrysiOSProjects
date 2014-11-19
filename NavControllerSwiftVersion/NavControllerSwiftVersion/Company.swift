//
//  Company.swift
//  NavControllerSwiftVersion
//
//  Created by Aditya Narayan on 11/17/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

import UIKit

class Company: NSObject {
   
    var name: String
    var image: String?
    var companyID: Int
    var products: [Product]
    
    init (name: String, image: String, companyID: Int) {
        self.name = name
        self.image = image
        self.companyID = companyID
        self.products = []
    }
}
