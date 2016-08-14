//
//  ViewController.swift
//  ielts-listening
//
//  Created by Binh Le on 5/9/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedAction:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getLessonList(actionIndex:Int) -> LevelObject {
        let levelObject = LevelObject()
        let levelParser = LevelParser()
        if actionIndex == 1 {
            levelObject.levelId = "1"
            levelObject.levelName = "BASIC LEVEL"
            levelObject.lessonArray = levelParser.getLessonList("1")
            return levelObject
        }
        else if actionIndex == 2 {
            levelObject.levelId = "2"
            levelObject.levelName = "INTERMEDIATE LEVEL"
            levelObject.lessonArray = levelParser.getLessonList("2")
            return levelObject
        }
        levelObject.levelId = "3"
        levelObject.levelName = "ADVANCED LEVEL"
        levelObject.lessonArray = levelParser.getLessonList("3")
        return levelObject
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SEGUE_PARENT_CATEGORY" {
            let viewController = segue.destinationViewController as! CategoryViewController
            viewController.levelObject = self.getLessonList(self.selectedAction!)
        }
    }
    
    func buyFullVersion() {
        
        let alertView:UIAlertController = UIAlertController.init(title: "Upgrade", message: "Buy Full Version to Remove ads and Have INTERMEDIATE LEVEL + ADVANCED LEVEL", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAlertAction = UIAlertAction.init(title: "Later", style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction) in
        })
        let doAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (alert:UIAlertAction) in
            UIApplication.sharedApplication().openURL(NSURL.init(string: Constants.URL_APPSTORE_FULL)!)
        })
        
        alertView.addAction(cancelAlertAction)
        alertView.addAction(doAlertAction)
        presentViewController(alertView, animated: true, completion: nil)
        
    }
    
    @IBAction func basicAction(sender: UIButton) {
        self.selectedAction = 1
        self.performSegueWithIdentifier("SEGUE_PARENT_CATEGORY", sender: sender)
    }
    
    
    @IBAction func intermediateAction(sender: UIButton) {
//        self.selectedAction = 2
//        self.performSegueWithIdentifier("SEGUE_PARENT_CATEGORY", sender: sender)
        buyFullVersion()
    }
    
    
    @IBAction func advancedAction(sender: UIButton) {
//        self.selectedAction = 3
//        self.performSegueWithIdentifier("SEGUE_PARENT_CATEGORY", sender: sender)
        buyFullVersion()
    }

}

