//
//  TweetCell.swift
//  Twitter
//
//  Created by Chase McCoy on 2/12/16.
//  Copyright © 2016 Chase McCoy. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {
  @IBOutlet var usernameLabel: UILabel!
  @IBOutlet var tweetTextLabel: UILabel!
  @IBOutlet var userImageView: UIImageView!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var retweetButton: UIButton!
  @IBOutlet var likeButton: UIButton!
  
  let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "h:mm"
    return formatter
  }()
  
  var tweet: Tweet? {
    didSet {
      usernameLabel.text = tweet?.user.name
      tweetTextLabel.text = tweet?.text
      userImageView.setImageWithURL((tweet?.user.profileImageURL)!)
      dateLabel.text = dateFormatter.stringFromDate((tweet?.createdAt)!)
      
      setRetweetAndLikeImageStates()
    }
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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    userImageView.layer.cornerRadius = 30
    userImageView.clipsToBounds = true
    
    retweetButton.setBackgroundImage(UIImage(named: "retweet_active"), forState: .Disabled)
    likeButton.setBackgroundImage(UIImage(named: "like_active"), forState: .Disabled)
  }
  
  func tappedUserImageView() {
    
  }
  
  override func prepareForReuse() {
    userImageView.image = nil
    setRetweetAndLikeImageStates()
  }
}
