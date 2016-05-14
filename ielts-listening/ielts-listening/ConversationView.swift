//
//  ConversationView.swift
//  ielts-listening
//
//  Created by Binh Le on 5/14/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

class ConversationView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var conversationArray:NSMutableArray?
    var cellHeightArray = NSMutableArray()
    @IBOutlet weak var conversationTableView:UITableView!
    
    func initConversation(conversationArray:NSMutableArray) {
        
        self.conversationArray = conversationArray
        self.cellHeightCalculation()
        self.conversationTableView.reloadData()
        
    }
    
    /*
     - (void)calculateRowHeight{
     if (!_rowHeightArray) {
     _rowHeightArray = [[NSMutableArray alloc] init];
     }
     else{
     [_rowHeightArray removeAllObjects];
     }
     if (_appDelegate.isIPhone) {
     [self createExercise];
     }
     else {
     [self createExerciseOnIPad];
     }
     for (NSString *textString in _selectedLession.conversationArray) {
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
        myLabel.numberOfLines = 0;
        myLabel.lineBreakMode = NSLineBreakByWordWrapping;
        myLabel.text = textString;
        CGSize labelSize = [myLabel.text sizeWithFont:myLabel.font constrainedToSize:myLabel.frame.size lineBreakMode:NSLineBreakByWordWrapping];
        int delta = labelSize.height / 21;
        int originalHeight = 35;
        if (delta > 3) {
            originalHeight += 20;
        }
        NSString *heightValue = [NSString stringWithFormat:@"%d",(delta * 12) + originalHeight];
        [_rowHeightArray addObject:heightValue];
     }
     [_conversationTableView reloadData];
     }
     */
    
    func cellHeightCalculation() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        for i in 0...self.conversationArray!.count - 1 {
            let sentence:String = self.conversationArray![i] as! String
            let label = UILabel(frame: CGRectMake(0,0,screenSize.width,500))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.text = sentence
            label.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            label.sizeToFit()
            let delta = label.frame.size.height / 21
            var originalHeight:Int = 35
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
        return 35
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversationArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CELL_CONVERSATION", forIndexPath: indexPath)
        tableViewCell.textLabel?.text = self.conversationArray![indexPath.row] as? String
        tableViewCell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        tableViewCell.textLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        tableViewCell.textLabel?.numberOfLines = 0
        return tableViewCell

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
