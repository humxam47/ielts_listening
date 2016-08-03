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
        
        let dictionary = [
            "LEVEL_ID": levelId,
            "LESSON_ID": lessonId
        ]
        Constants.userDefault.setObject(dictionary, forKey: "LESSON_USER_DEFAULT")
        
    }
    
    func getLastLesson() -> NSDictionary {
        
        let dictionary = Constants.userDefault.objectForKey("LESSON_USER_DEFAULT")
        if dictionary != nil {
            return dictionary as! NSDictionary
        }
        return [
            "LEVEL_ID": "-1",
            "LESSON_ID": "-1"
        ]
        
    }
    
    func storeDownloadedFile(levelId:String, lessonId:String) {
        
        let lessonsString:String! = Constants.userDefault.stringForKey("LESSON_DOWNLOAD_LIST")
        if (lessonsString == nil || lessonsString!.characters.count == 0) {
            Constants.userDefault.setObject("\(levelId)_\(lessonId)", forKey: "LESSON_DOWNLOAD_LIST")
            return
        }
        Constants.userDefault.setObject("\(lessonsString)$$$\(levelId)_\(lessonId)", forKey: "LESSON_DOWNLOAD_LIST")
        
    }
    
    func isFileDownloaded(levelId:String, lessonId:String) -> Bool {
        
        if let lessonsString = Constants.userDefault.stringForKey("LESSON_DOWNLOAD_LIST") {
            let lessonArray = lessonsString.componentsSeparatedByString("$$$")
            for lessonString:String in lessonArray {
                let levelAndLesson:NSArray! = lessonString.componentsSeparatedByString("_")
                if (levelAndLesson[0] as! String == levelId && levelAndLesson[1] as! String == lessonId) {
                    return true
                }
            }
        }
        return false
    }
    
}
