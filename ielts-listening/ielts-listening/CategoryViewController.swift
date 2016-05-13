//
//  CategoryViewController.swift
//  ielts-listening
//
//  Created by Binh Le on 5/10/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import Foundation

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var levelObject:LevelObject?
    @IBOutlet weak var backButton:UIButton!
    @IBOutlet weak var categoryTitle:UILabel!
    @IBOutlet weak var lessonCollection:UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController!.navigationBar.hidden = true
        
        self.initUI()
        self.addSwipeGesture()
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func initUI()  {
        
        if let levelObject = self.levelObject {
            self.categoryTitle.text = levelObject.levelName
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }


    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
//
//
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        
//    }
    
}