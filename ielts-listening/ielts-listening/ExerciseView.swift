//
//  ExerciseView.swift
//  ielts-listening
//
//  Created by Binh Le on 5/14/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class ExerciseView: UIView {
    
    @IBOutlet weak var scrollView:UIScrollView!
    var checkLabel:UILabel!
    
    var questionArray:NSMutableArray!
    var keyArray:NSMutableArray!
    var correctKeyArray:NSMutableArray!
    var buttonArray:NSMutableArray!
    var appColor = UIColor(red: 30/255, green: 159/255, blue: 243/255, alpha: 1)
    
    func initExersise(questionArray:NSMutableArray) {
        self.keyArray = NSMutableArray()
        self.correctKeyArray = NSMutableArray()
        self.buttonArray = NSMutableArray()
        self.refreshExercise(questionArray)
    }
    
    func refreshExercise(questionArray:NSMutableArray) {
        self.questionArray = questionArray
        if let keyArray = self.keyArray {
            keyArray.removeAllObjects()
        }
        if let correctKeyArray = self.correctKeyArray {
            correctKeyArray.removeAllObjects()
        }
        if let buttonArray = self.buttonArray {
            buttonArray.removeAllObjects()
        }
        for subView in self.scrollView.subviews {
            subView.removeFromSuperview()
        }
        self.createExercise()
    }
    
    func createExercise() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let xCoordinate:CGFloat = 20.0
        var yCoordinate:CGFloat = 10.0
        let width:CGFloat = 280.0
        let defaultHeight:CGFloat = 200.0
        var block:Int = 1
        var tagValue:Int = 0
        for i in 0...(self.questionArray!.count - 1) {
            let question:QuestionObject = self.questionArray![i] as! QuestionObject
            let questionBox:UIView = UIView(frame: CGRectMake(xCoordinate, yCoordinate, screenSize.width - (xCoordinate * 2), width))
            questionBox.backgroundColor = UIColor.clearColor()
            questionBox.layer.cornerRadius = 10.0
            questionBox.layer.shadowOffset = CGSizeMake(1, 0)
            questionBox.layer.shadowColor = UIColor.blackColor().CGColor
            questionBox.layer.borderWidth = 4
            questionBox.layer.borderColor = self.appColor.CGColor
            let questionLabel = UILabel(frame: CGRectMake(10, 10, questionBox.frame.size.width - 20, defaultHeight))
            questionLabel.backgroundColor = UIColor.clearColor()
            questionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
            questionLabel.numberOfLines = 0
            questionLabel.text = question.questionText
            questionLabel.sizeToFit()
            var questionFrame = questionLabel.frame
            questionFrame.size.height = questionLabel.frame.size.height
            questionLabel.frame = questionFrame
            questionBox.addSubview(questionLabel)
            
            var yAnswer = questionLabel.frame.origin.y + questionLabel.frame.size.height + 5
            for j in 0...(question.answerArray!.count - 1) {
                let answerObject:AnswerObject = question.answerArray![j] as! AnswerObject
                let answerButton = UIButton(type: UIButtonType.Custom)
                answerButton.frame = CGRectMake(10, yAnswer, questionBox.frame.size.width - 20, defaultHeight)
                answerButton.backgroundColor = UIColor.clearColor()
                self.keyArray.addObject("0")
                self.correctKeyArray.addObject(String(answerObject.answerValue))
                answerButton.tag = tagValue
                self.buttonArray.addObject(answerButton)
                tagValue += 1
                answerButton.addTarget(self, action:#selector(self.setButtonAnswer(_:)), forControlEvents:UIControlEvents.TouchUpInside)
                let answerLabel = UILabel(frame:answerButton.bounds)
                answerLabel.backgroundColor = UIColor.clearColor()
                answerLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
                var orderText:String
                switch (j+1) {
                case 1:
                    orderText = "a."
                    break
                case 2:
                    orderText = "b."
                    break
                case 3:
                    orderText = "c."
                    break
                case 4:
                    orderText = "d."
                    break
                default:
                    orderText = "a."
                    break
                }
                answerLabel.text = "\(orderText) \(answerObject.answerText)"
                answerLabel.numberOfLines = 0
                answerLabel.sizeToFit()
                var answerLabelFrame = answerLabel.frame
                answerLabelFrame.size.height = answerLabel.frame.size.height
                answerLabel.frame = answerLabelFrame
                
                var answerButtonFrame = answerButton.frame
                answerButtonFrame.size.height = answerLabel.frame.size.height
                answerButton.frame = answerButtonFrame
                answerButton.addSubview(answerLabel)
                
                questionBox.addSubview(answerButton)
                yAnswer += answerButton.frame.size.height + 10
            }
            block += 1
            var questionBoxFrame = questionBox.frame
            questionBoxFrame.size.height = yAnswer
            questionBox.frame = questionBoxFrame
            self.scrollView?.addSubview(questionBox)
            yCoordinate += yAnswer + 20
        }
        self.checkLabel = UILabel(frame: CGRectMake(screenSize.width/2 - 70, yCoordinate, 140, 35))
        self.checkLabel.backgroundColor = UIColor.clearColor()
        self.checkLabel.textColor = self.appColor
        self.checkLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        self.checkLabel.textAlignment = NSTextAlignment.Center
        self.checkLabel.clipsToBounds = true
        self.checkLabel.layer.cornerRadius = 5.0
        self.checkLabel.layer.borderColor = self.appColor.CGColor
        self.checkLabel.layer.borderWidth = 1.0
        self.checkLabel.text = "Check Answers"
        let checkButton = UIButton(type: UIButtonType.Custom)
        checkButton.frame = self.checkLabel.frame
        checkButton.backgroundColor = UIColor.clearColor()
        checkButton.addTarget(self, action: #selector(checkAnswer), forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(self.checkLabel)
        self.scrollView.addSubview(checkButton)
        var scrollViewSize = self.scrollView.contentSize
        scrollViewSize.height = self.checkLabel.frame.origin.y + self.checkLabel.frame.size.height + 30
        self.scrollView.contentSize = scrollViewSize
    }
    
    func setButtonAnswer(sender:UIButton!) {
        if sender.tag >= 0 && sender.tag <= 3 {
            for i in 0...3 {
                var keyString = self.keyArray[i] as! String
                let selectedButton:UIButton = self.buttonArray[i] as! UIButton
                if sender.tag == i {
                    if keyString == "0" {
                        keyString = "1"
                        selectedButton.backgroundColor = self.appColor
                    }
                    else {
                        keyString = "0"
                        selectedButton.backgroundColor = UIColor.clearColor()
                    }
                }
                else {
                    keyString = "0"
                    selectedButton.backgroundColor = UIColor.clearColor()
                }
                self.keyArray.replaceObjectAtIndex(i, withObject: keyString)
            }
        }
        else if sender.tag >= 4 && sender.tag <= 7 {
            for i in 4...7 {
                var keyString = self.keyArray[i] as! String
                let selectedButton:UIButton = self.buttonArray[i] as! UIButton
                if sender.tag == i {
                    if keyString == "0" {
                        keyString = "1"
                        selectedButton.backgroundColor = self.appColor
                    }
                    else {
                        keyString = "0"
                        selectedButton.backgroundColor = UIColor.clearColor()
                    }
                }
                else {
                    keyString = "0"
                    selectedButton.backgroundColor = UIColor.clearColor()
                }
                self.keyArray.replaceObjectAtIndex(i, withObject: keyString)
            }
        }
        else if sender.tag >= 8 && sender.tag <= 11 {
            for i in 8...11 {
                var keyString = self.keyArray[i] as! String
                let selectedButton:UIButton = self.buttonArray[i] as! UIButton
                if sender.tag == i {
                    if keyString == "0" {
                        keyString = "1"
                        selectedButton.backgroundColor = self.appColor
                    }
                    else {
                        keyString = "0"
                        selectedButton.backgroundColor = UIColor.clearColor()
                    }
                }
                else {
                    keyString = "0"
                    selectedButton.backgroundColor = UIColor.clearColor()
                }
                self.keyArray.replaceObjectAtIndex(i, withObject: keyString)
            }
        }
        else if sender.tag >= 12 && sender.tag <= 15 {
            for i in 12...15 {
                var keyString = self.keyArray[i] as! String
                let selectedButton:UIButton = self.buttonArray[i] as! UIButton
                if sender.tag == i {
                    if keyString == "0" {
                        keyString = "1"
                        selectedButton.backgroundColor = self.appColor
                    }
                    else {
                        keyString = "0"
                        selectedButton.backgroundColor = UIColor.clearColor()
                    }
                }
                else {
                    keyString = "0"
                    selectedButton.backgroundColor = UIColor.clearColor()
                }
                self.keyArray.replaceObjectAtIndex(i, withObject: keyString)
            }
        }
    }
    
    func checkAnswer() {
        if self.checkLabel.text == "Check Answers" {
            for i in 0...(self.correctKeyArray.count - 1) {
                let correctButton:UIButton = self.buttonArray[i] as! UIButton
                correctButton.enabled = false
                let correctString:String! = self.correctKeyArray[i] as! String
                if correctString == "1" {
                    let keyString = self.keyArray[i] as! String
                    if keyString == "1" {
                        correctButton.backgroundColor = self.appColor
                    }
                    else {
                        correctButton.backgroundColor = UIColor.redColor()
                    }
                }
                else {
                    correctButton.backgroundColor = UIColor.clearColor()
                }
            }
            self.checkLabel.layer.borderColor = UIColor.redColor().CGColor
            self.checkLabel.text = "Do Again"
            self.checkLabel.textColor = UIColor.redColor()
        } else {
            self.checkLabel.layer.borderColor = self.appColor.CGColor
            self.checkLabel.text = "Check Answers"
            self.checkLabel.textColor = self.appColor
            self.refreshExercise(self.questionArray)
        }
    }
}