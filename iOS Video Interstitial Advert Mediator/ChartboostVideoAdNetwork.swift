//
//  ChartboostVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

class ChartboostVideoAdNetwork: VideoAdNetwork {
    weak var delegate: VideoAdNetworkDelegate?
    init(appID: String, appSignature: String) {
        print("Chartboost initializer")
    }
    func requestAd() {
        print("Chartboost Ad Requested")
    }
}
