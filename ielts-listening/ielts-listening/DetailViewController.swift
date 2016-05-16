//
//  DetailViewController.swift
//  ielts-listening
//
//  Created by Binh Le on 5/14/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class DetailViewController: UIViewController, ControllerDelegate, UIAlertViewDelegate {
    
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
        self.controllerView.userInteractionEnabled = false
        self.showProgressHUD("Loading...")
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
        if let controllerView = self.controllerView {
            controllerView.stopAudio()
        }
    }
    
    func showProgressHUD(text:String) {
        dispatch_async(dispatch_get_main_queue()) {
            let showHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            showHUD.mode = MBProgressHUDMode.Indeterminate
            showHUD.labelText = text
        }
    }
    
    func showExerciseView() {
        self.conversationView.hidden = true
        self.exerciseView.hidden = false
    }
    
    func showConversationView() {
        self.conversationView.hidden = false
        self.exerciseView.hidden = true
    }
    
    func hideLoading() {
        dispatch_async(dispatch_get_main_queue()) {
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        }
    }
    
    func showNotification(message: String, cancelString: String, actionString: String) {
        dispatch_async(dispatch_get_main_queue()) {
            let alertView = UIAlertView.init(title:"", message: message, delegate: self, cancelButtonTitle: actionString, otherButtonTitles: cancelString)
            alertView.show()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            if let controllerView = self.controllerView {
                controllerView.playInThread()
            }
            break;
        default:
            break;
        }
    }
}
