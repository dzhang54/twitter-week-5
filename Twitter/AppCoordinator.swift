//
//  AppCoordinator.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/28/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject, AuthorizationCoordinatorDelegate, TweetCoordinatorDelegate {
  var window: UIWindow!
  var childCoordinators = [NSObject]()
  
  init(window: UIWindow) {
    super.init()
    self.window = window
  }
  
  func start() {
    if User.currentUser != nil {
      showContent()
    }
    else {
      showAuthentication()
    }
  }
  
  func showContent() {
    let tweetCoordinator = TweetCoordinator(window: window)
    tweetCoordinator.delegate = self
    childCoordinators.append(tweetCoordinator)
    tweetCoordinator.start()
  }
  
  func showAuthentication() {
    let authCoordinator = AuthorizationCoordinator(window: window)
    authCoordinator.delegate = self
    childCoordinators.append(authCoordinator)
    authCoordinator.start()
  }
  
  func coordinatorDidAuthenticate(coordinator: AuthorizationCoordinator) {
    if let index = childCoordinators.indexOf({ $0 == coordinator }) {
      childCoordinators.removeAtIndex(index)
    }
    showContent()
  }
  
  func userDidLogOut(coordinator: TweetCoordinator) {
    if let index = childCoordinators.indexOf({ $0 == coordinator }) {
      childCoordinators.removeAtIndex(index)
    }
    showAuthentication()
  }

}
