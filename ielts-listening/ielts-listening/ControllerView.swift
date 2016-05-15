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
    
    var audioPlayer:AVAudioPlayer!
    
    var lessonArray:NSMutableArray!
    var selectedIndex:Int = 0
    
    weak var controllerDelegate:ControllerDelegate!
    
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
            audioPlayer.volume = 1.0
            audioPlayer.delegate = self
            audioPlayer.play()
        } catch {
            print("Error getting the audio file")
        }
    }
    
    @IBAction func playAction(sender:UIButton) {
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
    
}
