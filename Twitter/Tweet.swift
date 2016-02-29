//
//  Tweet.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  var user: User
  var text: String
  var createdAtString: String?
  var createdAt: NSDate?
  var dictionary: NSDictionary
  var favoritesCount: Int?
  var retweetCount: Int?
  var id: String
  var isLiked: Bool
  var isRetweeted: Bool
  
  init(dictionary: NSDictionary) {
    self.dictionary = dictionary
    
    user = User(dictionary: dictionary["user"] as! NSDictionary)
    text = dictionary["text"] as! String
    createdAtString = dictionary["created_at"] as? String
    
    let formatter = NSDateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    createdAt = formatter.dateFromString(createdAtString!)
    
    favoritesCount = dictionary["favorite_count"] as? Int
    retweetCount = dictionary["retweet_count"] as? Int
    
    id = dictionary["id_str"] as! String
    
    isLiked = dictionary["favorited"] as! Bool
    isRetweeted = dictionary["retweeted"] as! Bool
  }
  
  class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()
    
    for dictionary in array {
      tweets.append(Tweet(dictionary: dictionary))
    }
    
    return tweets
  }
}
