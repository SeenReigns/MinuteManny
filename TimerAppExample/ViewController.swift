//
//  ViewController.swift
//  TimerAppExample
//
//  Created by CallumHill on 18/11/20.
//

import UIKit

class ViewController: UIViewController
{
	@IBOutlet weak var TimerLabel: UILabel!
	@IBOutlet weak var startStopButton: UIButton!
	@IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var manual: UIButton!
    @IBOutlet weak var manualTimer: UILabel!
    @IBOutlet weak var avgManualTime: UILabel!
    @IBOutlet weak var avgManualTimeLabel: UILabel!
    @IBOutlet weak var skateboard: UIImageView!
    @IBOutlet weak var totTimeLabel: UILabel!
    @IBOutlet weak var TotTime: UILabel!
    @IBOutlet weak var longest: UILabel!
    var timer:Timer = Timer()
    var timer2:Timer = Timer()
	var count:Int = 0
	var timerCounting:Bool = false
    var count2:Int = 0
    var timerCounting2:Bool = false
    var mannynumber = 0
    var totaltimecount = 0
    var mannycounts = [Int]()
    var sumArray = 0
    var avgArrayValue = 0
    var longestno = 0
    var locker = 0
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		startStopButton.setTitleColor(UIColor.green, for: .normal)
	}

	@IBAction func resetTapped(_ sender: Any)
	{
		let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
			//do nothing
		}))
		
		alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
			self.count = 0
			self.timer.invalidate()
			self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.count2 = 0
            self.timer2.invalidate()
            self.manualTimer.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.TotTime.text = String(0)
            self.totaltimecount = 0
            self.mannycounts = [Int]()
            self.avgManualTime.text = String(0)
            self.locker = 0
            self.longestno = 0
            self.longest.text = String(self.longestno)
			self.startStopButton.setTitle("START", for: .normal)
			self.startStopButton.setTitleColor(UIColor.green, for: .normal)
		}))
		
		self.present(alert, animated: true, completion: nil)
	}
    
    @IBAction func manualTapped(_ sender: Any)
    {
        
        // check if number is greater than 0
        
        if(mannynumber == 0 && timerCounting == false && locker == 0) {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        if (mannynumber == 0 && locker == 0) {
            timerCounting2 = true
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter2), userInfo: nil, repeats: true)
            var imagemanual: UIImage = UIImage(named: "skatemanual")!
            self.skateboard.image = imagemanual
            self.skateboard.transform = CGAffineTransform(translationX: 0, y: 0)
            mannynumber = 1
            print("hey")
            print(self.locker)
            print(mannynumber)
        }
        else if (mannynumber == 1 && locker == 0) {
            timerCounting2 = false
            timer2.invalidate()
            var image: UIImage = UIImage(named: "skate")!
            self.skateboard.image = image
            self.skateboard.transform = CGAffineTransform(translationX: 0, y: 0)
            mannynumber = 0
            print("Ho!")
            print(self.locker)
            if(count2>=2)
            {
                totaltimecount = totaltimecount+count2
                print(totaltimecount)
                let time2 = secondsToHoursMinutesSeconds(seconds: totaltimecount)
    //            let timeString2 = makeTimeString(hours: time2.0, minutes: time2.1, seconds: time2.2)
                TotTime.text = String(time2.2)
                mannycounts.append(count2)
                self.sumArray = mannycounts.reduce(0, +)
                self.avgArrayValue = sumArray / mannycounts.count
                self.avgManualTime.text = String(self.avgArrayValue)
                if(count2 > longestno){
                    longestno = count2
                    longest.text = String(longestno)
                }
                print(mannycounts)
                print(avgArrayValue)
                print(longest)
            }
            self.count2 = 0
            self.timer2.invalidate()
            self.manualTimer.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            
        }
        
//        self.skateboard.image = UIImage(imageLiteralResourceName: "skatemanual")
        
    }
	
	@IBAction func startStopTapped(_ sender: Any)
	{
		if(timerCounting && locker == 0)
		{
            print("de")
			timerCounting = false
			timer.invalidate()
			startStopButton.setTitle("START", for: .normal)
			startStopButton.setTitleColor(UIColor.green, for: .normal)
		}
        else if(timerCounting==false && locker == 0)
		{
            print("bug")
			timerCounting = true
			startStopButton.setTitle("STOP", for: .normal)
			startStopButton.setTitleColor(UIColor.red, for: .normal)
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
		}
	}
	
	@objc func timerCounter() -> Void
	{
		count = count + 1
		let time = secondsToHoursMinutesSeconds(seconds: count)
		let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
		TimerLabel.text = timeString
	}
    
    @objc func timerCounter2() -> Void
    {
        count2 = count2 + 1
        let time = secondsToHoursMinutesSeconds(seconds: count2)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        manualTimer.text = timeString
        if(totaltimecount+count2 >= 60){
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
            timerCounting2 = false
            timer2.invalidate()
            self.locker = 1
            print("locker")
            print(self.locker)
            totaltimecount = totaltimecount+count2
            print(totaltimecount)
            let time2 = secondsToHoursMinutesSeconds(seconds: self.count)
            let timeString2 = makeTimeString(hours: time2.0, minutes: time2.1, seconds: time2.2)
            TotTime.text = String(totaltimecount)
            mannycounts.append(count2)
            self.sumArray = mannycounts.reduce(0, +)
            self.avgArrayValue = sumArray / mannycounts.count
            self.avgManualTime.text = String(self.avgArrayValue)
            print(mannycounts)
            print(avgArrayValue)
            if(count2 > longestno){
                longestno = count2
                longest.text = String(longestno)
            }
            var image: UIImage = UIImage(named: "skate")!
            self.skateboard.image = image
            self.skateboard.transform = CGAffineTransform(translationX: 0, y: 0)
            let alert = UIAlertController(title: "Congrats!", message: "You achieved 60 seconds of manual in: "+String(timeString2), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Noice!", style: .cancel, handler: { (_) in
                //do nothing
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
	
	func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
	{
		return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
	}
	
	func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
	{
		var timeString = ""
		timeString += String(format: "%02d", hours)
		timeString += " : "
		timeString += String(format: "%02d", minutes)
		timeString += " : "
		timeString += String(format: "%02d", seconds)
		return timeString
	}
	
	
}

