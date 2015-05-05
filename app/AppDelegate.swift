//
//  AppDelegate.swift
//  Loader
//
//  Created by Pierre-Guillaume Herveou on 4/11/15.
//  Copyright (c) 2015 Jogabo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var window: UIWindow? = {
    let window = FBTweakShakeWindow(frame: UIScreen.mainScreen().bounds)
    return window
    }()
}

