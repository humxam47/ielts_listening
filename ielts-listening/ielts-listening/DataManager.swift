//
//  DataManager.swift
//  ielts-listening
//
//  Created by Binh Le on 5/16/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class DataManager {
    
    class var sharedInstance:DataManager {
        struct Static {
            static var oneToken: dispatch_once_t = 0
            static var instance:DataManager? = nil
        }
        dispatch_once(&Static.oneToken) {
            Static.instance = DataManager()
        }
        return Static.instance!
    }
    
    func storeLastLesson(levelId:String, lessonId:String) {
        let lessonUserDefault = NSUserDefaults.standardUserDefaults()
        let dictionary = ["LEVEL_ID": levelId, "LESSON_ID": lessonId]
        lessonUserDefault.setObject(dictionary, forKey: "LESSON_USER_DEFAULT")
    }
    
    func getLastLesson() -> NSDictionary {
        let lessonUserDefault = NSUserDefaults.standardUserDefaults()
        let dictionary = lessonUserDefault.objectForKey("LESSON_USER_DEFAULT")
        if dictionary != nil {
            return dictionary as! NSDictionary
        }
        return ["LEVEL_ID": "-1", "LESSON_ID": "-1"]
    }
    
}
