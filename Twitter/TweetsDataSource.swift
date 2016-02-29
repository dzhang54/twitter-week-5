//
//  TweetsDataSource.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

protocol TweetDataSource {
  func updateTweet(tweet: Tweet, forIndexPath indexPath: NSIndexPath)
}

class TweetsDataSource: NSObject, UITableViewDataSource, TweetDataSource {
  var tweets: [Tweet]?
  var tweetViewController: TweetsViewController?
  
  var delegate: TweetDelegate?
  
  func tweetForIndex(indexPath: NSIndexPath) -> Tweet? {
    if let tweets = tweets {
      return tweets[indexPath.row]
    }
    return nil
  }
  
  func latestTweetID() -> String? {
    if let tweets = tweets {
      return tweets[0].id
    }
    return nil
  }
  
  func oldestTweetID() -> String? {
    if let tweets = tweets {
      return tweets[tweets.count - 1].id
    }
    return nil
  }
  
  func addNewTweets(newTweets: [Tweet]?) {
    if let newTweets = newTweets {
      if tweets != nil {
        tweets!.insertContentsOf(newTweets, at: 0)
      }
      else {
        tweets = newTweets
      }
    }
  }
  
  func addOldTweets(oldTweets: [Tweet]?) {
    if let oldTweets = oldTweets {
      tweets?.removeAtIndex((tweets?.count)! - 1)
      tweets?.appendContentsOf(oldTweets)
    }
  }
  
  func updateTweet(tweet: Tweet, forIndexPath indexPath: NSIndexPath) {
    tweets?[indexPath.row] = tweet
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let tweets = tweets {
      return tweets.count
    }
    else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    
    let gr = UITapGestureRecognizer(target: tweetViewController, action: "tappedUserImageView:")
    gr.numberOfTapsRequired = 1
    cell.userImageView.addGestureRecognizer(gr)
    
    cell.tweet = tweets![indexPath.row]
    
    return cell
  }
}
