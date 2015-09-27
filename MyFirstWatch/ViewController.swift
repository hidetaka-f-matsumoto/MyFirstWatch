//
//  ViewController.swift
//  MyFirstWatch
//
//  Created by 松本 英高 on 2015/09/26.
//  Copyright © 2015年 Hidetaka Matsumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.text = "Hello swift!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

