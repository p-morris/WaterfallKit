//
//  ViewController.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 26/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mediator: VideoAdMediator!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let settings = VideoAdNetworkSettings()
            .initializeAdColony(appID: "appd829e808336f4c31a0", zoneID: "vz5ae8090ed15442be8b")
            .initializeAppLovin(
                sdkKey: "sft8Tn2LETCqO7mlIdrehAIZl6We08AU_U_ikaTDxvfp-E_NgytxsQdRrB8hi5olXC5DLvzHgtVOQlwb4tQ76D"
            )
        mediator = VideoAdMediator(settings: settings)
        mediator.delegate = self
        mediator.requestAds()
    }

}

extension ViewController: VideoAdMediatorDelegate {
    func mediator(_ mediator: VideoAdMediator, didLoad adverts: [VideoAd]) {
        adverts.first?.display(from: self, or: UIApplication.shared.keyWindow!)
    }
    func mediator(_ mediator: VideoAdMediator, loadFailedWith error: Error) {
        print(error)
    }
}
