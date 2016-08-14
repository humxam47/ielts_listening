//
//  RatingHandler.swift
//  ielts-listening
//
//  Created by Binh Le on 7/24/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import Foundation

class RatingHandler {
    
    class var sharedInstance:RatingHandler {
        struct Static {
            static var oneToken: dispatch_once_t = 0
            static var instance: RatingHandler? = nil
        }
        dispatch_once(&Static.oneToken) {
            Static.instance = RatingHandler()
        }
        return Static.instance!
    }
    
    private func isUserRated() -> Bool {
        
        if let rateValue:Int = Constants.userDefault.integerForKey("USERDEFAULT_IS_RATED") {
            if rateValue == 1 {
                return true
            }
        }
        return false
        
    }
    
    func setUserRated() {
        
        Constants.userDefault.setInteger(1, forKey:"USERDEFAULT_IS_RATED")
        
    }
    
    private func getOpenningCount() -> Int {
        
        if let openCount:Int = Constants.userDefault.integerForKey("USERDEFAULT_OPEN_COUNT") {
            return openCount
        }
        return 0
        
    }
    
    func setOpenningCount(value: Int) {

        Constants.userDefault.setInteger(value, forKey:"USERDEFAULT_OPEN_COUNT")
        
    }
    
    func shouldShowRatePopup() -> Bool {
        
        if isUserRated() {
            return false
        }
        
        let openCount = getOpenningCount()
        if openCount == Constants.RATE_MAX_OPEN {
            return true
        }
        
        self.setOpenningCount(openCount + 1)
        return false
        
    }
    
}