//
//  WebViewController.swift
//  NavControllerSwiftVersion
//
//  Created by Aditya Narayan on 11/19/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var product: Product!
    @IBOutlet var myWebView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        self.myWebView = WKWebView(frame: self.view.frame)
        self.myWebView.navigationDelegate = self;
        var url = NSURL(string:product.url)
        var req = NSURLRequest(URL:url!)
        self.myWebView.loadRequest(req)
        self.view.addSubview(self.myWebView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
