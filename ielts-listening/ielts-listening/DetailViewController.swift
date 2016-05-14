//
//  DetailViewController.swift
//  ielts-listening
//
//  Created by Binh Le on 5/14/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var timeSlider:UISlider!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var playButton:UIButton!
    @IBOutlet weak var exerciseButton:UIButton!
    
    var lessonObject:LessonObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        self.addSwipeGesture()
    }
    
    func initUI() {
        if let lessonObject = self.lessonObject {
            
            self.titleLabel.text = lessonObject.lessonName
            self.titleLabel.textColor = UIColor(red: 30/255, green: 159/255, blue: 243/255, alpha: 1)

        }
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
}
