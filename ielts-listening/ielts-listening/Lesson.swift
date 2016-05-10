//
//  Lesson.swift
//  ielts-listening
//
//  Created by Binh Le on 5/10/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import Foundation

class Lesson {
    
    let lessonId:String
    let lessonName:String
    let lessonPath:String
    let conversationsArray:[String]
    let questionsArray:[String]
    
    init(lessonId:String, lessonName:String, lessonPath:String, conversationsArray:[String], questionsArray:[String]) {
        
        self.lessonId = lessonId
        self.lessonName = lessonName
        self.lessonPath = lessonPath
        self.conversationsArray = conversationsArray
        self.questionsArray = questionsArray
        
    }
    
}
