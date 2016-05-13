//
//  LessonObject.swift
//  ielts-listening
//
//  Created by Binh Le on 5/13/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class LessonObject {
    
    let lessonId:String
    let lessonName:String
    let lessonPath:String
    let conversationArray:[String]
    let questionArray:[QuestionObject]
    
    init(lessonId:String, lessonName:String, lessonPath:String, conversationArray:[String], questionArray:[QuestionObject]) {
        self.lessonId = lessonId
        self.lessonName = lessonName
        self.lessonPath = lessonPath
        self.conversationArray = conversationArray
        self.questionArray = questionArray
    }
    
}
