//
//  DAO.swift
//  NavControllerSwiftVersion
//
//  Created by Aditya Narayan on 11/17/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

import UIKit

class DAO: NSObject {
   
    var companies: [Company]?
    
    override init() {
        super.init()
        self.companies = self.createDefaultCompanies()
    }
    
    func createDefaultCompanies () -> [Company] {
        
        var apple: Company = Company(name: "Apple", image: "apple", companyID:1)
        var samsung: Company = Company(name: "Samsung", image: "samsung", companyID:2)
        var htc: Company = Company(name: "HTC", image: "htc", companyID: 3)
        var motorola: Company = Company(name: "Motorola", image: "motorola.gif", companyID: 4)
        
        var myCompanies = [apple, samsung, htc, motorola]
        
        return myCompanies
    }
    
}
