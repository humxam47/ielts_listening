//
//  CategoryViewController.swift
//  ielts-listening
//
//  Created by Binh Le on 5/10/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import Foundation

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var levelObject:LevelObject!
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
            self.categoryTitle.textColor = UIColor(red: 30/255, green: 159/255, blue: 243/255, alpha: 1)
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
    
    func isPlayed(levelIndex:Int) -> Bool {
        return levelIndex%2 == 0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.levelObject.lessonArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "CELL_IDENTIFIER"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CategoryCollectionViewCell
        var imageName = "lesson_" + String((indexPath.row + 1)) + ".png"
        if self.isPlayed(indexPath.row) {
            imageName = "lesson_" + String((indexPath.row + 1)) + "_tap.png"
        }
        cell.imageView.image = UIImage(named: imageName)
        // Configure the cell
        return cell
    }


    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let lessonObject:LessonObject = (self.levelObject.lessonArray![indexPath.row]) as! LessonObject
        print("lesson name: \(lessonObject.lessonName)")
    }
//
//
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        
//    }
    
}