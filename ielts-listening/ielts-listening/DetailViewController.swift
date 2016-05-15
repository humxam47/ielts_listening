//
//  DetailViewController.swift
//  ielts-listening
//
//  Created by Binh Le on 5/14/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class DetailViewController: UIViewController, ControllerDelegate {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var timeSlider:UISlider!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var playButton:UIButton!
    
    @IBOutlet weak var conversationView:ConversationView!
    @IBOutlet weak var exerciseView:ExerciseView!
    @IBOutlet weak var controllerView:ControllerView!
    
    var levelObject:LevelObject!
    var lessonObject:LessonObject!
    var lessonIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        self.initConversation()
        self.initExercise()
        self.addSwipeGesture()
        self.initController()
    }
    
    func initUI() {
        self.titleLabel.text = self.lessonObject.lessonName?.uppercaseString
        self.titleLabel.textColor = UIColor(red: 30/255, green: 159/255, blue: 243/255, alpha: 1)
    }
    
    func initConversation() {
        self.conversationView.initConversation(self.lessonObject.conversationArray!)
    }
    
    func initExercise() {
        self.exerciseView.initExersise(self.lessonObject.questionArray!)
    }
    
    func initController() {
        self.controllerView.initController(self.levelObject.lessonArray, selectedIndex: lessonIndex)
        self.controllerView.controllerDelegate = self
    }
    
    func addSwipeGesture() {
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action:#selector(responseRightGesture(_:)))
        rightGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightGesture)
        
    }
    
    func responseRightGesture(gesture:UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                self.backAction()
                break
            default:
                break
            }
        }
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showExerciseView() {
        self.conversationView.hidden = true
        self.exerciseView.hidden = false
    }
    
    func showConversationView() {
        self.conversationView.hidden = false
        self.exerciseView.hidden = true
    }
}
