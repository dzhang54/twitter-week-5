//
//  ViewController.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

protocol LoginDelegate {
  func didLoginSuccessfully()
}

class LoginViewController: UIViewController {
  
  var delegate: LoginDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func onLogin(sender: AnyObject) {
    TwitterClient.sharedInstance.loginWithCompletion({(user: User?, error: NSError?) in
      if user != nil {
        self.delegate?.didLoginSuccessfully()
      }
      else {
        // handle login error
      }
    })
  }

}

