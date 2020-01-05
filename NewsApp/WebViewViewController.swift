//
//  WebViewViewController.swift
//  NewsApp
//
//  Created by Osman Khan on 7/26/19.
//  Copyright © 2019 4491-IOS. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    var url: String?
    
    @IBOutlet weak var webview: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.loadRequest(URLRequest(url:URL(string: url!)!))

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
