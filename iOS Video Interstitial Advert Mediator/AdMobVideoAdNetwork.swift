//
//  AdMobVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

class AdMobVideoAdNetwork: VideoAdNetwork {
    weak var delegate: VideoAdNetworkDelegate?
    var priority = 0
    init(appID: String, adUnitID: String) {
        print("AdMob initializer")
    }
    func requestAd() {
        print()
    }
    func isEqual(to anotherAdNetwork: VideoAdNetwork) -> Bool {
        return true
    }
}
