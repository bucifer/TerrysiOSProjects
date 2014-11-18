//
//  Company.swift
//  NavControllerSwiftVersion
//
//  Created by Aditya Narayan on 11/17/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

import UIKit

class Company: NSObject {
   
    var name: String?
    var image: String?
    
    init (name: String, image: String) {
        self.name = name
        self.image = image
    }
}
