//
//  HomeTimeLineViewController.swift
//  TwitterClone
//
//  Created by Brian Mendez on 10/6/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import UIKit
//added import accounts oct7th
import Accounts
//for SLRequest
import Social

class HomeTimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    
    var tweets : [Tweet]?
    var twitterAccount : ACAccount?
    var networkController : NetworkController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Timeline"
        
        //registering NIB
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TWEET_CELL")
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        self.networkController.fetchHomeTimeLine { (errorDescription, tweets) -> (Void) in
            if errorDescription != nil {
                
            } else {
                self.tweets = tweets
                self.tableView.reloadData()
            }
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
            let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
            let tweet = self.tweets?[indexPath.row]
            cell.userTweetsLabel?.text = tweet?.text
            if tweet?.tweetPicture == nil { //if we dont have the picture already
                networkController.downloadUserImageForTweet(tweet!, completionHandler: { (image) -> (Void) in
                    cell.twitterProfilePic.image = image
            })
            } else {
                 cell.twitterProfilePic.image = tweet?.tweetPicture
            }
            cell.retweetsLabel.text = "\(tweet!.retweet)"
            cell.favoritesLabel.text = "\(tweet!.favorited)"
            return cell
        }
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let newVC = self.storyboard?.instantiateViewControllerWithIdentifier("DETAIL_VC") as DetailTweetViewController
//            let tweet = self.tweets?[indexPath.row]
            newVC.detailTweet = self.tweets?[indexPath.row]
            self.navigationController?.pushViewController(newVC, animated: true)
            
        }
}