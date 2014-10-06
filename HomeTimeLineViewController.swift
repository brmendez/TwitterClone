//
//  HomeTimeLineViewController.swift
//  TwitterClone
//
//  Created by Brian Mendez on 10/6/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import UIKit

class HomeTimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var tweets : [Tweet]?
    
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //JSON
        
        if let path = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
            var err : NSError?
            //where file lives
            let jsonData = NSData(contentsOfFile: path)
            
            self.tweets = Tweet.parseJSONDataIntoTweets(jsonData)
            self.tweets = self.tweets?.sorted({ (s1:Tweet, s2:Tweet) -> Bool in
                return s1.text < s2.text
            })
            
            self.tweets = self.tweets?.sorted({ (s1:Tweet, s2:Tweet) -> Bool in
                return s1.idString < s2.idString
            })

        }
    }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if self.tweets != nil {
            return self.tweets!.count
            } else {
                return 0
            }
        }
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            //1. dequeue cell
            let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as UITableViewCell
            //2. figure out which model object youre going to use to configure the cell
            let tweet = self.tweets?[indexPath.row]
            cell.textLabel?.text = tweet?.text
            //3. return cell
            return cell
        }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    }
