//
//  UserDetailViewController.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
  @IBOutlet var bannerImageView: UIImageView!
  @IBOutlet var userImageView: UIImageView!
  @IBOutlet var usernameLabel: UILabel!
  @IBOutlet var handleLabel: UILabel!
  @IBOutlet var tweetCountLabel: UILabel!
  @IBOutlet var followersCountLabel: UILabel!
  @IBOutlet var followingCountLabel: UILabel!
  
  var user: User! {
    didSet {
      navigationItem.title = user.name
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    userImageView.layer.cornerRadius = 45
    userImageView.clipsToBounds = true
    
    usernameLabel.text = user.name
    handleLabel.text = "@" + user.username
    
    bannerImageView.setImageWithURL(user.bannerImageURL!)
    userImageView.setImageWithURL(user.profileImageURL!)
    view.sendSubviewToBack(bannerImageView)
    
    tweetCountLabel.text = "\(user.tweetCount!)"
    followersCountLabel.text = "\(user.followersCount!)"
    followingCountLabel.text = "\(user.followingCount!)"
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
