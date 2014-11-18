//
//  DAO.swift
//  NavControllerSwiftVersion
//
//  Created by Aditya Narayan on 11/17/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

import UIKit

let appleID = 0
let samsungID = 1
let htcID = 2
let motorolaID = 3

class DAO: NSObject {
   
    var companies: [Company]?
    
    override init() {
        super.init()
        self.companies = self.createDefaultCompanies()
    }
    
    func createDefaultCompanies () -> [Company] {
        
        var apple: Company = Company(name: "Apple", image: "apple", companyID:appleID)
        var samsung: Company = Company(name: "Samsung", image: "samsung", companyID:samsungID)
        var htc: Company = Company(name: "HTC", image: "htc", companyID: htcID)
        var motorola: Company = Company(name: "Motorola", image: "motorola.gif", companyID: motorolaID)
        
        var myCompanies = [apple, samsung, htc, motorola]
        
        return myCompanies
    }
    
    func createDefaultProducts () -> [Product] {
        
        var ipod: Product = Product(name: "iPod", image: "ipod_touch", url:"https://www.google.com/#q=ipod+touch", companyID: appleID)
        var iphone: Product = Product(name: "iPhone", image: "iphone", url: "https://www.google.com/#q=iphone", companyID: appleID)
        var ipad: Product = Product(name: "iPad", image: "ipad", url: "https://www.google.com/#q=iPad", companyID: appleID)
        
        var myProducts = [ipod, iphone, ipad]
        
        return myProducts
        
    }
    
    
}
