//
//  ControllerView.swift
//  ielts-listening
//
//  Created by Binh Le on 5/15/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class ControllerView: UIView {
    
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var playButton:UIButton!
    @IBOutlet weak var exerciseButton:UIButton!
    
    var lessonArray:NSMutableArray!
    var selectedIndex:Int = 0
    
    weak var controllerDelegate:ControllerDelegate!
    
    func initController(lessonArray:NSMutableArray, selectedIndex:Int) {
        self.lessonArray = lessonArray
        self.selectedIndex = selectedIndex
        self.playExecution()
    }
    
    func playExecution() {
        let lessonObject:LessonObject = self.lessonArray[self.selectedIndex] as! LessonObject
        print("lesson: \(lessonObject.lessonName)")
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
