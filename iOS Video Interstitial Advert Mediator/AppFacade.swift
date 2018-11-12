//
//  AppFacade.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 12/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

class AppFacade {
    /// The network settings object
    var networkSettings: VideoAdNetworkSettings = {
        return VideoAdNetworkSettings()
        .initializeVungle(
            appID: "5bdabc7240a3d6043470ab1c",
            placementID: "PLAY-5685970"
        ).initializeChartboost(
            appID: "5bd976e57565ee60e0a466d4",
            appSignature: "1494c01152664f847872cb19ece5adc81fba78b7"
        ).initializeAdMob(
            appID: "ca-app-pub-3940256099942544~1458002511",
            adUnitID: "ca-app-pub-3940256099942544/4411468910"
        ).initializeAppLovin(
            sdkKey: "sft8Tn2LETCqO7mlIdrehAIZl6We08AU_U_ikaTDxvfp-E_NgytxsQdRrB8hi5olXC5DLvzHgtVOQlwb4tQ76D"
        ).initializeAdColony(
            appID: "appd829e808336f4c31a0",
            zoneID: "vz5ae8090ed15442be8b"
        )
    }()
    /**
     Sets the `rootViewController` on `window` and makes `window` key and visible.
     
     - Parameters:
     - window: The `UIWindow` to use for the application.
     - mav: The `UINavigationController` to embed the `TableViewController` in.
     */
    func configure(window: UIWindow = UIWindow(),
                   nav: UINavigationController = UINavigationController()) -> UIWindow {
        window.makeKeyAndVisible()
        let controller = TableViewController(settings: networkSettings)
        nav.setViewControllers([controller], animated: false)
        window.rootViewController = nav
        return window
    }
}
