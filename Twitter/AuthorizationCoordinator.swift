//
//  AuthorizationCoordinator.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

protocol AuthorizationCoordinatorDelegate {
  func coordinatorDidAuthenticate(coordinator: AuthorizationCoordinator)
}

class AuthorizationCoordinator: NSObject, LoginDelegate {
  var window: UIWindow!
  var childCoordinators = [AnyObject]()
  
  var delegate: AuthorizationCoordinatorDelegate?
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let vc = storyboard.instantiateViewControllerWithIdentifier("LoginController") as! LoginViewController
    vc.delegate = self
    window.rootViewController = vc
  }
  
  func didLoginSuccessfully() {
    delegate?.coordinatorDidAuthenticate(self)
  }

}
