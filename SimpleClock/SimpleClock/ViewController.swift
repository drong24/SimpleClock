//
//  ViewController.swift
//  SimpleClock
//
//  Created by Daisy Rong on 6/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var durationPicked: UIDatePicker!
    
    @IBOutlet weak var countdownLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let df = DateFormatter()
        df.dateFormat = "E, d MMM yyyy HH:mm:ss"
        // updates date and time per second
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { Timer in
            let now = df.string(from: Date())
            self.dateTimeLabel.text = now
            let hour = Calendar.current.component(.hour, from: Date())
            // changes background image depending if its am or pm
            if (hour < 12) {
                self.bgImage.image = UIImage.dayBackground
            }
            else {
                self.bgImage.image = UIImage.nightBackground
            }
        }
    }
    
    @IBAction func timerButton(_ sender: UIButton) {
        countdownLabel.text =  String(durationPicked.countDownDuration)
    }
}

