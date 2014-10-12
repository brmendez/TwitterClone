//
//  NetworkController.swift
//  TwitterClone
//
//  Created by Brian Mendez on 10/8/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import Foundation
import Accounts
import Social

// completion handlers are closures
//closures can be passed as if they are variables

class NetworkController {
    
    var tweets : [Tweet]?
    var tweet : Tweet?

    var twitterAccount : ACAccount?
    
    init () {

        
    }
    
    func fetchHomeTimeLine (completionHandler: (errorDescription: String?, tweets: [Tweet]?) -> (Void)) {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted : Bool, error : NSError!) -> Void in if granted {
            
            
            
                let accounts = accountStore.accountsWithAccountType(accountType)
                self.twitterAccount = accounts.first as ACAccount?
                //setup our twitter account
            
                let url = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
                let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: url, parameters: nil)
                twitterRequest.account = self.twitterAccount
            
                    twitterRequest.performRequestWithHandler({ (data, httpResponse, error) -> Void in
                        switch httpResponse.statusCode {
                        case 200...299:
                            let tweets = Tweet.parseJSONDataIntoTweets(data)
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                completionHandler(errorDescription: nil, tweets: tweets)
                                
                            })
                            //we are then put on to a background queue
                            
                        case 400...499:
                            println("This is the clients fault")
                        case 500...599:
                            println("This is the servers fault")
                            
                        default:
                            println("Something bad happened")
                        }
            
                        
                    })
            }
        }
    }
    
    func fetchUserTweets (screenname: String, completionHandler: (errorDescription: String?, tweets: [Tweet]?) -> (Void)) {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted : Bool, error : NSError!) -> Void in if granted {
            
            let accounts = accountStore.accountsWithAccountType(accountType)
            self.twitterAccount = accounts.first as ACAccount?
            //setup our twitter account
            
            let url = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(screenname)")
            let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: url, parameters: nil)
            twitterRequest.account = self.twitterAccount
            
            twitterRequest.performRequestWithHandler({ (data, httpResponse, error) -> Void in
                switch httpResponse.statusCode {
                case 200...299:
                    
                    let tweets = Tweet.parseJSONDataIntoTweets(data)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completionHandler(errorDescription: nil, tweets: tweets)
                        
                    })
                    //we are then put on to a background queue
                    
                case 400...499:
                    println("This is the clients fault")
                case 500...599:
                    println("This is the servers fault")
                    
                default:
                    println("Something bad happened")
                }
                
                
            })
            }
        }
    }
    
    func downloadUserImageForTweet(tweet : Tweet, completionHandler: (Image: UIImage) -> (Void)) {
        let url = NSURL(string: tweet.avatarURL)
        let imageData = NSData(contentsOfURL: url!) //network call
        let avatarImage = UIImage(data: imageData!)
        tweet.tweetPicture = avatarImage
        completionHandler(Image: avatarImage!)
    }
}