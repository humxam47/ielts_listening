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
    
    func isPlayed(levelIndex:Int) -> Bool {
        return levelIndex%2 == 0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SEGUE_CATEGORY_DETAIL" {
            let dataDictionary:NSDictionary = sender as! NSDictionary
            let viewController = segue.destinationViewController as! DetailViewController
            viewController.levelObject = dataDictionary["LEVEL_OBJECT"] as! LevelObject
            viewController.lessonObject = dataDictionary["LESSON_OBJECT"] as! LessonObject
            viewController.lessonIndex = dataDictionary["LESSON_INDEX"] as! Int
        }
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
        let imageName = "lesson_" + String((indexPath.row + 1)) + ".png"
//        if self.isPlayed(indexPath.row) {
//            imageName = "lesson_" + String((indexPath.row + 1)) + "_tap.png"
//        }
        cell.imageView.image = UIImage(named: imageName)
        // Configure the cell
        return cell
    }


    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let lessonObject = (self.levelObject.lessonArray![indexPath.row]) as! LessonObject
        let dataDictionary:NSDictionary = [
            "LEVEL_OBJECT":self.levelObject,
            "LESSON_OBJECT":lessonObject,
            "LESSON_INDEX":indexPath.row
        ]
        self.performSegueWithIdentifier("SEGUE_CATEGORY_DETAIL", sender:dataDictionary)
    }
    
}