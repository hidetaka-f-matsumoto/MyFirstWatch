//
//  InterfaceController.swift
//  MyFirstWatch WatchKit Extension
//
//  Created by 松本 英高 on 2015/09/26.
//  Copyright © 2015年 Hidetaka Matsumoto. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    var tasks: [NSURLSessionDataTask] = []
    var isActive: Bool = false

    @IBOutlet weak var button: WKInterfaceButton!
    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet weak var image: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        label.setText("Hello watchOS2")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.isActive = true
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        self.isActive = false
        for t in self.tasks {
            if t.state == NSURLSessionTaskState.Running {
                t.cancel()
            }
        }
    }

    @IBAction func buttonDidTap() {
        let url = NSURL(string:"https://dl.dropboxusercontent.com/u/17354346/example/charas.json")!
        let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: conf)
        let task = session.dataTaskWithURL(url) { (data, res, err) -> Void in
            if let e = err {
                print("dataTaskWithURL fail: \(e.debugDescription)")
                return
            }
            if let d = data {
                let dict = try! NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                debugPrint(dict)
                let charas = dict["charas"] as! NSArray
                let info = charas[0] as! NSDictionary
                self.label.setText(info["name"] as? String)
                self.updateImage(info["image_url"] as! String)
            }
            // TODO: self.tasks.remove(task)
        }
        task.resume()
        self.tasks.append(task)
    }
    
    func updateImage(imageUrl: String) {
        let url = NSURL(string:imageUrl)!
        let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: conf)
        let task = session.dataTaskWithURL(url) { (data, res, error) -> Void in
            if let e = error {
                print("dataTaskWithURL fail: \(e.debugDescription)")
                return
            }
            if let d = data {
                let image = UIImage(data: d)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if self.isActive {
                        self.image.setImage(image)
                    }
                })
            }
            // TODO: self.tasks.remove(task)
        }
        task.resume()
        self.tasks.append(task)
    }
}
