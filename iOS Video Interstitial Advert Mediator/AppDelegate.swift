//
//  AppDelegate.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 26/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, VideoAdMediatorDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let settings = VideoAdNetworkSettings()
            .initializeAdColony(appID: "Pete", zoneIDs: ["Hello"])
            .initializeMoPub(adUnitID: "helo")
            .initializeAdMob(appID: "dsdasd", adUnitID: "dasdasdsad")
            .initializeMoPub(adUnitID: "adsdasdasd")
        let mediator = VideoAdMediator(settings: settings)
        mediator.delegate = self
        mediator.requestAds()
        return true
    }
    
    func mediator(_ mediator: VideoAdMediator, didLoad adverts: [VideoAd]) {
        //
    }
    
    func mediator(_ mediator: VideoAdMediator, loadFailedWith error: Error) {
        //
    }
}
