//
//  AppLovinVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

class AppLovinVideoAdNetwork: VideoAdNetwork {
    weak var delegate: VideoAdNetworkDelegate?
    init(sdkKey: String) {
        print("AppLovin initializer")
    }
    func requestAd() {
        print("AppLovin Ad Requested")
    }
}
