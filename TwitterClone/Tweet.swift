//
//  Tweet.swift
//  TwitterClone
//
//  Created by Brian Mendez on 10/6/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import UIKit


class Tweet {
    //With CLASSES, it needs default value, marked as optional, or has to have initializer
    var text : String
    var tweetPicture : UIImage?
    var retweet : Int
    var favorited : Int
    var id : String
    var avatarURL : String
//    var screenname : String

    init (tweetInfo : NSDictionary) {
        self.text = tweetInfo["text"] as String
        self.retweet = tweetInfo["retweet_count"] as Int
        self.id = tweetInfo["id_str"] as String
        var userDict = tweetInfo["user"] as NSDictionary
        self.favorited = tweetInfo["favorite_count"] as Int
        let userInfo = tweetInfo["user"] as NSDictionary
        self.avatarURL = userInfo["profile_image_url"] as String
//        let screennameString = tweetInfo["screen_name"] as String
//        self.screenname = "@\(screennameString)"
    }
    
    class func parseJSONDataIntoTweets(rawJSONData : NSData) -> [Tweet]? {
        var error : NSError?
        
        if let JSONArray = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSArray {
            
            var tweets = [Tweet]()
            
            for JSONDictionary in JSONArray {
                
                if let tweetDictionary = JSONDictionary as? NSDictionary {
                    var newTweet = Tweet(tweetInfo: tweetDictionary)
                    
                    tweets.append(newTweet)
                }
            }
            return tweets
        }
        return nil
    }
}