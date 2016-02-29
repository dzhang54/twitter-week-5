//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  @IBOutlet var usernameLabel: UILabel!
  @IBOutlet var tweetTextLabel: UILabel!
  @IBOutlet var userImageView: UIImageView!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var retweetButton: UIButton!
  @IBOutlet var likeButton: UIButton!
  @IBOutlet var retweetCountLabel: UILabel!
  @IBOutlet var likeCountLabel: UILabel!
  @IBOutlet var replyButton: UIButton!
  
  let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "h:mm"
    return formatter
  }()
  
  var tweet: Tweet!
  var indexPath: NSIndexPath!
  
  var delegate: TweetDelegate?
  var dataSource: TweetDataSource?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userImageView.layer.cornerRadius = 30
    userImageView.clipsToBounds = true
    
    retweetButton.setBackgroundImage(UIImage(named: "retweet_active"), forState: .Disabled)
    likeButton.setBackgroundImage(UIImage(named: "like_active"), forState: .Disabled)
    
    usernameLabel.text = tweet?.user.name
    tweetTextLabel.text = tweet?.text
    userImageView.setImageWithURL((tweet?.user.profileImageURL)!)
    dateLabel.text = dateFormatter.stringFromDate((tweet?.createdAt)!)
    
    retweetCountLabel.text = "\((tweet.retweetCount)!)"
    likeCountLabel.text = "\((tweet.favoritesCount)!)"
    
    setRetweetAndLikeImageStates()
    
    let gr = UITapGestureRecognizer(target: self, action: "tappedUserImageView:")
    gr.numberOfTapsRequired = 1
    userImageView.addGestureRecognizer(gr)
  }
  
  @IBAction func retweetButtonPressed(sender: AnyObject) {
    delegate?.tweetWasRetweeted((tweet?.id)!, completion: { (tweet) -> () in
      self.tweet.isRetweeted = true
      self.tweet.retweetCount! += 1
      self.retweetCountLabel.text = "\((self.tweet.retweetCount)!)"
      self.setRetweetAndLikeImageStates()
      self.dataSource?.updateTweet(self.tweet, forIndexPath: self.indexPath)
    })
  }
  
  @IBAction func likeButtonPressed(sender: AnyObject) {
    delegate?.tweetWasLiked((tweet?.id)!, completion: { (tweet) -> () in
      self.tweet.isLiked = true
      self.tweet.favoritesCount! += 1
      self.likeCountLabel.text = "\((self.tweet.favoritesCount)!)"
      self.setRetweetAndLikeImageStates()
      self.dataSource?.updateTweet(self.tweet, forIndexPath: self.indexPath)
    })
  }
  
  @IBAction func replyButtonPressed(sender: UIButton) {
    delegate?.replyButtonPressed(tweet.user)
  }
  
  func tappedUserImageView(sender: UITapGestureRecognizer) {
    delegate?.userImageViewPressed((tweet?.user)!)
  }
  
  func setRetweetAndLikeImageStates() {
    if let isRetweeted = tweet?.isRetweeted {
      if isRetweeted {
        retweetButton.setBackgroundImage(UIImage(named: "retweet_active"), forState: .Normal)
        retweetButton.enabled = false
      }
      else {
        retweetButton.setBackgroundImage(UIImage(named: "retweet_inactive"), forState: .Normal)
        retweetButton.enabled = true
      }
    }
    
    
    if let isLiked = tweet?.isLiked {
      if isLiked {
        likeButton.setBackgroundImage(UIImage(named: "like_active"), forState: .Normal)
        likeButton.enabled = false
      }
      else {
        likeButton.setBackgroundImage(UIImage(named: "like_inactive"), forState: .Normal)
        likeButton.enabled = true
      }
    }
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
