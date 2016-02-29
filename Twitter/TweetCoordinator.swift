//
//  TweetCoordinator.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

protocol TweetDelegate {
  func userDidLogOut()
  func tweetWasCreated(tweetText: String)
  func tweetWasRetweeted(tweetID: String, completion: (tweet: Tweet) -> ())
  func tweetWasLiked(tweetID: String, completion: (tweet: Tweet) -> ())
  func tweetCellPressed(tweet: Tweet, forIndexPath indexPath: NSIndexPath, withDataSource dataSource: TweetsDataSource)
  func newTweetButtonPressed()
  func replyButtonPressed(inReplyTo: User)
  func userImageViewPressed(user: User)
}

protocol TweetCoordinatorDelegate {
  func userDidLogOut(coordinator: TweetCoordinator)
}

class TweetCoordinator: NSObject, TweetDelegate {
  var window: UIWindow!
  var delegate: TweetCoordinatorDelegate?
  
  init(window: UIWindow) {
    super.init()
    self.window = window
  }
  
  func start() {
    if User.currentUser != nil {
      let vc = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationController") as! UINavigationController
      let tweetsViewController = vc.topViewController as! TweetsViewController
      tweetsViewController.delegate = self
      window?.rootViewController = vc
    }
  }
  
  // MARK: - TweetDelegate
  
  func userDidLogOut() {
    delegate?.userDidLogOut(self)
  }
  
  func tweetWasCreated(tweetText: String) {
    TwitterClient.sharedInstance.createTweetWithText(tweetText) { (tweet, error) -> () in
      if let _ = tweet {
        let nc = self.window.rootViewController as! UINavigationController
        nc.popViewControllerAnimated(true)
      }
    }
  }
  
  func tweetCellPressed(tweet: Tweet, forIndexPath indexPath: NSIndexPath, withDataSource dataSource: TweetsDataSource) {
    let nc = window.rootViewController as! UINavigationController
    let detailView = storyboard.instantiateViewControllerWithIdentifier("TweetDetailViewController") as! TweetDetailViewController
    detailView.tweet = tweet
    detailView.indexPath = indexPath
    detailView.delegate = self
    detailView.dataSource = dataSource
    nc.pushViewController(detailView, animated: true)
  }
  
  func newTweetButtonPressed() {
    let nc = window.rootViewController as! UINavigationController
    let newTweetView = storyboard.instantiateViewControllerWithIdentifier("NewTweetViewController") as! NewTweetViewController
    newTweetView.delegate = self
    nc.pushViewController(newTweetView, animated: true)
  }
  
  func replyButtonPressed(inReplyTo: User) {
    let nc = window.rootViewController as! UINavigationController
    let newTweetView = storyboard.instantiateViewControllerWithIdentifier("NewTweetViewController") as! NewTweetViewController
    newTweetView.delegate = self
    newTweetView.inReplyToUser = inReplyTo
    nc.pushViewController(newTweetView, animated: true)
  }
  
  
  func userImageViewPressed(user: User) {
    let nc = window.rootViewController as! UINavigationController
    let detailView = storyboard.instantiateViewControllerWithIdentifier("UserDetailViewController") as! UserDetailViewController
    detailView.user = user
    nc.pushViewController(detailView, animated: true)
  }
  
  func tweetWasRetweeted(tweetID: String, completion: (tweet: Tweet) -> ()) {
    TwitterClient.sharedInstance.retweetTweetWithID(tweetID) { (tweet, error) -> () in
      if let tweet = tweet {
        completion(tweet: tweet)
      }
    }

  }
  
  func tweetWasLiked(tweetID: String, completion: (tweet: Tweet) -> ()) {
    TwitterClient.sharedInstance.favoriteTweetWithID(tweetID) { (tweet, error) -> () in
      if let tweet = tweet {
        completion(tweet: tweet)
      }
    }
  }
}
