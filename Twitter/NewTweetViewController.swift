//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
  @IBOutlet var tweetTextView: UITextView!
  
  var inReplyToUser: User?
  var delegate: TweetDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tweetButton = UIBarButtonItem(title: "Tweet", style: .Done, target: self, action: "tweetButtonPressed:")
    navigationItem.rightBarButtonItem = tweetButton
    
    if let user = inReplyToUser {
      tweetTextView.text = "@\(user.username) "
    }
    
    tweetTextView.becomeFirstResponder()
  }
  
  func tweetButtonPressed(sender: UIBarButtonItem) {
    delegate?.tweetWasCreated(tweetTextView.text)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
