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
    
    @IBOutlet weak var startTimerButton: UIButton!
    
    var timer = Timer()
    var duration : Double?
    var timerEnded = false
    
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
        // check if button is for start timer or stop music
        if (timerEnded == false) {
            sender.isUserInteractionEnabled = false
            sender.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            duration = durationPicked.countDownDuration
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)
            //countdownLabel.text = String(format: "%.1f", duration!)
        }
        else {
            startTimerButton.setTitle("Start Timer", for: .normal)
            timerEnded = false
        }

    }
    
    @objc func startCountDown() {
        if (duration! >= 0) {
            countdownLabel.text = String(format: "%.1f", duration!)
            duration! -= 1.0;
        }
        else {
            timer.invalidate()
            timerEnded = true
            startTimerButton.isUserInteractionEnabled = true
            startTimerButton.backgroundColor = UIColor.clear
            startTimerButton.setTitle("Stop Music", for: .normal)
        }
    }
}

