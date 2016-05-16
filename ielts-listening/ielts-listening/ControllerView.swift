//
//  ControllerView.swift
//  ielts-listening
//
//  Created by Binh Le on 5/15/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import AVFoundation

class ControllerView: UIView, AVAudioPlayerDelegate {
    
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var playButton:UIButton!
    @IBOutlet weak var exerciseButton:UIButton!
    
    var lessonArray:NSMutableArray!
    var selectedIndex:Int = 0
    
    weak var controllerDelegate:ControllerDelegate!
    
    var audioPlayer:AVAudioPlayer!
    var progressTimer:NSTimer!
    
    func initController(lessonArray:NSMutableArray, selectedIndex:Int) {
        self.lessonArray = lessonArray
        self.selectedIndex = selectedIndex
        let playThread = NSThread(target: self, selector: #selector(playExecution), object: nil)
        playThread.start()
    }
    
    func playExecution() {
        let lessonObject:LessonObject = self.lessonArray[self.selectedIndex] as! LessonObject
        do {
            let soundURL = "https://raw.githubusercontent.com/ryanle-gamo/english-listening-data/master/\(lessonObject.lessonPath)"
            let soundData = NSData(contentsOfURL:NSURL(string:soundURL)!)
            self.audioPlayer = try AVAudioPlayer(data: soundData!)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = AVAudioSession.sharedInstance().outputVolume
            audioPlayer.delegate = self
            audioPlayer.play()
            if self.audioPlayer != nil {
                self.initProgress()
            }
        } catch {
            print("Error getting the audio file")
        }
    }
    
    func initProgress() {
        dispatch_async(dispatch_get_main_queue()) {
            self.slider.minimumValue = 0.0
            self.slider.maximumValue = Float(self.audioPlayer.duration)
            self.progressTimer = NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(self.progressTimer, forMode: NSRunLoopCommonModes)
        }
    }
    
    func updateProgress() {
        self.slider.value = Float(self.audioPlayer.currentTime)
        self.timeLabel.text = self.formatTime(Int(self.audioPlayer.duration - self.audioPlayer.currentTime))
    }
    
    func formatTime(totalSecond:Int) -> String {
        let twoDecimalSecond = String(format: "%02d", totalSecond % 60)
        let twoDecimalMinutes = String(format: "%02d", (totalSecond / 60) % 60)
        return "-\(twoDecimalMinutes):\(twoDecimalSecond)"
    }
    
    @IBAction func playAction(sender:UIButton) {
        sender.tag *= -1
        if sender.tag > 0 {
            self.playButton.setBackgroundImage(UIImage(named: "icon_pause.png"), forState:UIControlState.Normal)
            self.audioPlayer.play()
        } else {
            self.playButton.setBackgroundImage(UIImage(named: "icon_play.png"), forState:UIControlState.Normal)
            self.audioPlayer.pause()
        }
    }
    
    @IBAction func nextAction(sender:UIButton) {
        if self.selectedIndex < (self.lessonArray.count - 1) {
            self.selectedIndex += 1
            self.playExecution()
        }
    }
    
    @IBAction func previousAction(sender:UIButton) {
        if self.selectedIndex > 0 {
            self.selectedIndex -= 1
            self.playExecution()
        }
    }
    
    @IBAction func sliderChanged(sender:UISlider) {
        self.audioPlayer.currentTime = NSTimeInterval(self.slider.value)
        self.timeLabel.text = self.formatTime(Int(self.audioPlayer.duration - NSTimeInterval(self.slider.value)))
    }
    
    @IBAction func exerciseAction(sender:UIButton) {
        sender.tag *= -1
        if sender.tag > 0 {
            self.exerciseButton.setTitle("Exercises", forState: UIControlState.Normal)
            self.controllerDelegate?.showConversationView()
        } else {
            self.exerciseButton.setTitle("Transcript", forState: UIControlState.Normal)
            self.controllerDelegate?.showExerciseView()
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        self.slider.value = 0.0
        self.progressTimer.invalidate()
        self.progressTimer = nil
    }
    
}
