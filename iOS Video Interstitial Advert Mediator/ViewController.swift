//
//  ViewController.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 26/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mediator: VideoAdLoader!
    let runloop = RunLoop.main
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 04e0a6d592374d1d9a60e244a0946898
        // 16245f7ff8514ce4be549008817aaddc video
        let settings = VideoAdNetworkSettings()
            //.initializeVungle(appID: "5bdabc7240a3d6043470ab1c", placementID: "PLAY-5685970")
            //.initializeChartboost(appID: "incorrecty", appSignature: "dasdsad")
            .initializeChartboost(appID: "5bd976e57565ee60e0a466d4", appSignature: "1494c01152664f847872cb19ece5adc81fba78b7")
            //.initializeAdMob(appID: "ca-app-pub-3940256099942544~1458002511", adUnitID: "ca-app-pub-3940256099942544/4411468910")
            //.initializeAppLovin(sdkKey: "sft8Tn2LETCqO7mlIdrehAIZl6We08AU_U_ikaTDxvfp-E_NgytxsQdRrB8hi5olXC5DLvzHgtVOQlwb4tQ76D")
            //.initializeAdColony(appID: "appd829e808336f4c31a0", zoneID: "vz5ae8090ed15442be8b")
        mediator = VideoAdLoader(settings: settings)
        mediator.delegate = self
        mediator.requestAds()
    }

}

extension ViewController: VideoAdLoaderDelegate {
    func mediator(_ mediator: VideoAdLoader, didLoad adverts: [VideoAd]) {
        adverts.first?.display(from: self, or: UIApplication.shared.keyWindow!)
    }
    func mediator(_ mediator: VideoAdLoader, loadFailedWith error: Error) {
        print(error)
    }
}
