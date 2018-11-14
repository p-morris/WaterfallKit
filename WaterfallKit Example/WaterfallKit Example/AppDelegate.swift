//
//  AppDelegate.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 26/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// The object responsible for configuring the rootViewController
    let appFacade = AppFacade()
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = appFacade.configure()
        return true
    }
}
