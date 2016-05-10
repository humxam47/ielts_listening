//
//  CategoryViewController.swift
//  ielts-listening
//
//  Created by Binh Le on 5/10/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import Foundation

class CategoryViewController: UIViewController {
    
    var selectedAction:Int?
    @IBOutlet weak var backButton:UIButton!
    @IBOutlet weak var categoryTitle:UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController!.navigationBar.hidden = true
        
        self.initUI()
        self.addSwipeGesture()
    }
    
    func initUI()  {
        
        switch self.selectedAction! {
        case 1:
            self.categoryTitle.text = "Basic Level"
            break
        case 2:
            self.categoryTitle.text = "Intermediate Level"
            break
        case 3:
            self.categoryTitle.text = "Advanced Level"
            break
        default:
            self.categoryTitle.text = "Basic Level"
        }
        
    }
    
    func addSwipeGesture() {
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action:#selector(responseRightGesture(_:)))
        rightGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightGesture)
        
    }
    
    func responseRightGesture(gesture:UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                self.backAction()
                break
            default:
                break
            }
        }
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}