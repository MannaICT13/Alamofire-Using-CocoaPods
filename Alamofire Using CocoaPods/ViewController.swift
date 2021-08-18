//
//  ViewController.swift
//  Alamofire Using CocoaPods
//
//  Created by Sharetrip-iOS on 18/08/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://httpbin.org/get"
        AF.request(urlString).response { (response) in
            debugPrint(response)
        }
        
       
    }


}

