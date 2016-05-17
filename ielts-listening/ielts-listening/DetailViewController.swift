//
//  DetailViewController.swift
//  ielts-listening
//
//  Created by Binh Le on 5/14/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import MBProgressHUD
import SSZipArchive
import AFNetworking

class DetailViewController: UIViewController, ControllerDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var timeSlider:UISlider!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var playButton:UIButton!
    @IBOutlet weak var downloadButton:UIButton!
    
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
        self.storeLastAccessLesson()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.backAction()
    }
    
    func initUI() {
        self.refreshUI()
    }
    
    func refreshUI() {
        self.titleLabel.text = self.lessonObject.lessonName?.uppercaseString
        self.titleLabel.textColor = UIColor(red: 30/255, green: 159/255, blue: 243/255, alpha: 1)
        self.downloadButton.enabled = !DataManager.sharedInstance.isFileDownloaded(self.levelObject.levelId, lessonId: self.lessonObject.lessonId)
    }
    
    func initConversation() {
        self.conversationView.initConversation(self.lessonObject.conversationArray!)
    }
    
    func initExercise() {
        self.exerciseView.initExersise(self.lessonObject.questionArray!)
    }
    
    func initController() {
        self.controllerView.controllerDelegate = self
        self.controllerView.initController(self.levelObject.lessonArray, selectedIndex: lessonIndex)
    }
    
    func storeLastAccessLesson() {
        DataManager.sharedInstance.storeLastLesson(self.levelObject.levelId, lessonId: self.lessonObject.lessonId)
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
        if let controllerView = self.controllerView {
            controllerView.stopAudio()
        }
    }
    
    @IBAction func downloadAction() {
        DataManager.sharedInstance.storeDownloadedFile(self.levelObject.levelId, lessonId: self.lessonObject.lessonId)
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
    
    func showLoading() {
        dispatch_async(dispatch_get_main_queue()) {
            self.showProgressHUD("Loading...")
        }
    }
    
    func hideLoading() {
        dispatch_async(dispatch_get_main_queue()) {
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        }
    }
    
    func changeLessonWithIndex(lessonIndex: Int) {
        self.lessonObject = self.levelObject.lessonArray[lessonIndex] as! LessonObject
        self.refreshUI()
        self.conversationView.refreshConversation(self.lessonObject.conversationArray)
        self.exerciseView.initExersise(self.lessonObject.questionArray)
        self.storeLastAccessLesson()
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
        case 1:
            self.hideLoading()
            break;
        default:
            break;
        }
    }
}
