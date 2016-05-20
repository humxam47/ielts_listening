//
//  ConversationView.swift
//  ielts-listening
//
//  Created by Binh Le on 5/14/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class ConversationView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var conversationArray:NSMutableArray!
    var cellHeightArray:NSMutableArray!
    var cellHeight:Int!
    var cellFont:UIFont!
    var cellCalculationFont:UIFont!
    @IBOutlet weak var conversationTableView:UITableView!
    
    func initConversation(conversationArray:NSMutableArray) {
        self.cellHeightArray = NSMutableArray()
        self.refreshConversation(conversationArray)
    }
    
    func prepareForPhone() {
        self.cellHeight = 35
        self.cellFont = UIFont(name: "HelveticaNeue-Light", size: 17)
        self.cellCalculationFont = UIFont(name: "HelveticaNeue-Light", size: 20)
    }
    
    func prepareForPad() {
        self.cellHeight = 50
        self.cellFont = UIFont(name: "HelveticaNeue-Light", size: 20)
        self.cellCalculationFont = UIFont(name: "HelveticaNeue-Light", size: 23)
    }
    
    func refreshConversation(conversationArray:NSMutableArray) {
        self.conversationArray = conversationArray
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            self.prepareForPhone()
            break
        case .Pad:
            self.prepareForPad()
            break
        default:
            self.prepareForPhone()
            break
        }
        
        if let cellHeightArray = self.cellHeightArray {
            cellHeightArray.removeAllObjects()
        }
        self.cellHeightCalculation()
        self.conversationTableView.reloadData()
    }
    
    func cellHeightCalculation() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        for i in 0...self.conversationArray!.count - 1 {
            let sentence:String = self.conversationArray![i] as! String
            let label = UILabel(frame: CGRectMake(0,0,screenSize.width,500))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.text = sentence
            label.font = self.cellCalculationFont!
            label.sizeToFit()
            let delta = label.frame.size.height / 21
            var originalHeight:Int = self.cellHeight!
            if Int(delta) > 3 {
                originalHeight += 20
            }
            let heightInt = (Int(delta) * 12) + originalHeight
            cellHeightArray.addObject(String(heightInt))
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let n = NSNumberFormatter().numberFromString(self.cellHeightArray[indexPath.row] as! String) {
            return CGFloat(n)
        }
        return CGFloat(self.cellHeight!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversationArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CELL_CONVERSATION", forIndexPath: indexPath)
        tableViewCell.textLabel?.text = self.conversationArray![indexPath.row] as? String
        tableViewCell.textLabel?.font = self.cellFont
        tableViewCell.textLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        tableViewCell.textLabel?.numberOfLines = 0
        tableViewCell.backgroundColor = UIColor.clearColor()
        return tableViewCell

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
