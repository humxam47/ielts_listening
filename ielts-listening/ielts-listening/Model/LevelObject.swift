//
//  LevelObject.swift
//  ielts-listening
//
//  Created by Binh Le on 5/13/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class LevelObject {
    
    let levelId:String
    let levelName:String
    let lessonArray:[LessonObject]
    
    init(levelId:String, levelName:String, lessonArray:[LessonObject]) {
        self.levelId = levelId
        self.levelName = levelName
        self.lessonArray = lessonArray
    }
    
}