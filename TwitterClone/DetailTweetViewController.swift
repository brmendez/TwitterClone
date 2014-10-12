//
//  DetailTweetViewController.swift
//  TwitterClone
//
//  Created by Brian Mendez on 10/9/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {
    
    var detailTweet : Tweet?
    
    @IBOutlet weak var detailTwitterPic: UIImageView!
    @IBOutlet weak var detailTweetMessage: UILabel!
    @IBOutlet weak var detailRetweets: UILabel!
    @IBOutlet weak var detailFavorites: UILabel!
    @IBOutlet weak var screennameHeaderLabelDVC: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailTwitterPic.image = detailTweet?.tweetPicture
        self.detailTweetMessage.text = detailTweet?.text
        self.detailRetweets.text = String(detailTweet!.retweet)
        self.detailFavorites.text = String(detailTweet!.favorited)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func pictureButtonPressed(sender: UIButton) {
        let newVC = self.storyboard?.instantiateViewControllerWithIdentifier("HOME_VC") as HomeTimeLineViewController
        newVC.screenname = detailTweet?.screenname
        newVC.userPic = detailTweet?.tweetPicture
        
        self.navigationController?.pushViewController(newVC, animated: true)
        
    }
}