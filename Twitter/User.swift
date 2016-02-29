//
//  User.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "currentUser"

class User: NSObject {
  var name: String
  var username: String
  var profileImageURL: NSURL?
  var bannerImageURL: NSURL?
  var bio: String?
  var followersCount: Int?
  var followingCount: Int?
  var tweetCount: Int?
  var dictionary: NSDictionary
  
  class var currentUser: User? {
    get {
      if _currentUser == nil {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        if data != nil {
          let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
          _currentUser = User(dictionary: dictionary)
        }
    
      }
      return _currentUser
    }
    
    set(user) {
      _currentUser = user
      
      if _currentUser != nil {
        let data = try! NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: .PrettyPrinted)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
      }
      else {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
      }
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }
  
  init(dictionary: NSDictionary) {
    self.dictionary = dictionary
    
    name = dictionary["name"] as! String
    username = dictionary["screen_name"] as! String
    if let imageURLString = dictionary["profile_image_url_https"] as? String {
      let url = imageURLString.stringByReplacingOccurrencesOfString("_normal", withString: "_bigger")
      profileImageURL = NSURL(string: url)
    }
    if let bannerURLString = dictionary["profile_banner_url"] as? String {
      bannerImageURL = NSURL(string: bannerURLString)
    }
    bio = dictionary["description"] as? String
    
    followersCount = dictionary["followers_count"] as? Int
    followingCount = dictionary["friends_count"] as? Int
    tweetCount = dictionary["statuses_count"] as? Int
  }
  
  func logout() {
    User.currentUser = nil
    TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
  }
}
