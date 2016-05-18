//
//  DetailViewController.swift
//  ielts-listening
//
//  Created by Binh Le on 5/14/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import MBProgressHUD
import GoogleMobileAds

class DetailViewController: UIViewController, ControllerDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var timeSlider:UISlider!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var playButton:UIButton!
    @IBOutlet weak var downloadButton:UIButton!
    @IBOutlet weak var downloadIndicator:UIActivityIndicatorView!
    @IBOutlet weak var bannerView:GADBannerView!
    
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
        self.initAdmob()
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
    
    func initAdmob() {
        let admobBanner = "ca-app-pub-4322965078780162/4717761535"
        self.bannerView.adUnitID = admobBanner
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            self.bannerView.adSize = kGADAdSizeBanner
            break
        case .Pad:
            self.bannerView.adSize = kGADAdSizeLeaderboard
            break
        default:
            self.bannerView.adSize = kGADAdSizeBanner
            break
        }
        self.bannerView.loadRequest(GADRequest())
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
        if let controllerView = self.controllerView {
            controllerView.stopAudio()
        }
    }
    
    @IBAction func downloadAction() {
        NSThread(target: self, selector: #selector(self.downloadAudioFile), object: nil).start()
    }
    
    func downloadAudioFile() {
        dispatch_async(dispatch_get_main_queue()) {
            self.downloadButton.enabled = false
            self.downloadIndicator.startAnimating()
        }
        let fullPath:String! = "https://raw.githubusercontent.com/ryanle-gamo/english-listening-data/master/\(self.lessonObject.lessonPath)"
        let soundURL:NSURL! = NSURL.init(string: fullPath)
        let documentsDirectoryURL =  NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        let destinationUrl = documentsDirectoryURL.URLByAppendingPathComponent(soundURL.lastPathComponent!)
        NSURLSession.sharedSession().downloadTaskWithURL(soundURL, completionHandler: { (location, response, error) -> Void in
            guard let location = location where error == nil else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.downloadButton.enabled = true
                    self.downloadIndicator.stopAnimating()
                }
                return
            }
            do {
                try NSFileManager().moveItemAtURL(location, toURL: destinationUrl)
                DataManager.sharedInstance.storeDownloadedFile(self.levelObject.levelId, lessonId: self.lessonObject.lessonId)
                dispatch_async(dispatch_get_main_queue()) {
                    self.downloadIndicator.stopAnimating()
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                dispatch_async(dispatch_get_main_queue()) {
                    self.downloadButton.enabled = true
                    self.downloadIndicator.stopAnimating()
                }
            }
        }).resume()
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
