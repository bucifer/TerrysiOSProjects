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
    var products: [Product]?
    
    override init() {
        super.init()
        self.companies = self.createDefaultCompanies()
        self.products = self.createDefaultProducts()
        
        for company in self.companies! {
            for product in self.products! {
                if product.companyID == company.companyID {
                    company.products!.append(product)
                }
            }
        }
    }

    
    func createDefaultCompanies() -> [Company] {
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
        
        var note: Product = Product(name: "Galaxy Note", image: "galaxy_note", url: "https://www.google.com/#q=galaxy+note", companyID: samsungID)
        var s4: Product = Product(name: "Galaxy S4", image: "galaxy_s4", url: "https://www.google.com/#q=galaxys4", companyID: samsungID)
        var tab: Product = Product(name: "Galaxy Tab", image: "galaxy_tab", url: "https://www.google.com/#q=galaxy+tab", companyID: samsungID)
        
        var htc_one: Product=Product(name: "HTC One", image: "htc_one", url: "https://www.google.com/#q=htc+one", companyID: htcID)
        var htc_flyer: Product = Product(name: "HTC Flyer", image: "htc_flyer", url: "https://www.google.com/#q=htc+flyer", companyID: htcID)
        var htc_m8: Product = Product(name: "HTC M8", image: "htc_m8", url: "https://www.google.com/#q=htcm8", companyID: htcID)
        
        var moto_g: Product = Product(name: "Moto G", image: "moto_g", url: "https://www.google.com/#q=moto+g", companyID: motorolaID)
        var moto_x: Product = Product(name: "Moto X", image: "moto_x", url: "https://www.google.com/#q=moto+x", companyID: motorolaID)
        var moto_360: Product = Product(name: "Moto 360", image: "moto_360", url: "https://www.google.com/#q=moto360", companyID: motorolaID)
        
        var myProducts = [ipod, iphone, ipad, note, s4, tab, htc_one, htc_flyer, htc_m8, moto_g, moto_x, moto_360]
        
        return myProducts
    }
    
    
}
