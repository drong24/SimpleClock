//
//  ViewController.swift
//  SimpleClock
//
//  Created by Daisy Rong on 6/10/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var durationPicked: UIDatePicker!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var startTimerButton: UIButton!
    
    var timer = Timer()
    var duration : Double?
    var durationLabel : timeval?
    var timerEnded = false
    var url = Bundle.main.url(forResource: "timerEndSound", withExtension: "wav")
    var audioPlayer : AVAudioPlayer!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let hour = Calendar.current.component(.hour, from: Date())
        // changes background image depending if its am or pm
        if (hour < 12) {
            self.bgImage.image = UIImage.dayBackground
        }
        else {
            self.bgImage.image = UIImage.nightBackground
        }
        
        let df = DateFormatter()
        df.dateFormat = "E, d MMM yyyy HH:mm:ss"
        
        // updates clock every second
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { Timer in
            let now = df.string(from: Date())
            self.dateTimeLabel.text = now
        }
    }
    
    @IBAction func timerButton(_ sender: UIButton) {
        // check if button is for start timer or stop music
        if (timerEnded == false) {
            sender.isUserInteractionEnabled = false
            sender.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            duration = durationPicked.countDownDuration
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)
        }
        else {
            startTimerButton.setTitle("Start Timer", for: .normal)
            timerEnded = false
            audioPlayer.stop()
        }

    }
    
    @objc func startCountDown() {
        if (duration! >= 0) {
            durationLabel = timeval(tv_sec: Int(duration!), tv_usec: 0)
            countdownLabel.text = Duration(durationLabel!).formatted(.time(pattern: .hourMinuteSecond))
            duration! -= 1.0;
        }
        else {
            timer.invalidate()
            timerEnded = true
            startTimerButton.isUserInteractionEnabled = true
            startTimerButton.backgroundColor = UIColor.clear
            startTimerButton.setTitle("Stop Music", for: .normal)
            audioPlayer = try! AVAudioPlayer(contentsOf: url!)
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }
    }
}

