//
//  ViewController.swift
//  Pinboard
//
//  Created by Sagaya Abdulhafeez on 10/05/2019.
//  Copyright © 2019 cosmo. All rights reserved.
//

import UIKit
import CacheFramework


struct TestClas:Codable {
    var userId:Int
    var id:Int
    var title:String
    var body:String
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        CacheService.shared.fetchData(forUrl: "https://jsonplaceholder.typicode.com/posts", completion: { (response: [TestClas]) in
            print(response)
        }, error: nil)
    }
}

