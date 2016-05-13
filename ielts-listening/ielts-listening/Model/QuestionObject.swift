//
//  QuestionObject.swift
//  ielts-listening
//
//  Created by Binh Le on 5/13/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class QuestionObject {
    
    let questionText:String
    let questionArray:[AnswerObject]
    
    init(questionText:String, questionArray:[AnswerObject]) {
        self.questionText = questionText
        self.questionArray = questionArray
    }
}
