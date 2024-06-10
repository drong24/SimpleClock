//
//  ViewController.swift
//  SimpleClock
//
//  Created by Daisy Rong on 6/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    
    var currentDateTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let now = df.string(from: Date())
        dateTimeLabel.text = now
        print(currentDateTime)
    }
}

