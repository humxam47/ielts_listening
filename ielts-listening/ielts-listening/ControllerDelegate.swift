//
//  ControllerDelegate.swift
//  ielts-listening
//
//  Created by Binh Le on 5/15/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

protocol ControllerDelegate:class {
    func showConversationView()
    func showExerciseView()
    func hideLoading()
    func showNotification(message:String, cancelString:String, actionString:String)
}
