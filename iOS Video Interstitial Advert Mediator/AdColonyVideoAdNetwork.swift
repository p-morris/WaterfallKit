//
//  AdColonyVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

class AdColonyVideoAdNetwork: VideoAdNetwork {
    weak var delegate: VideoAdNetworkDelegate?
    init(appID: String, zoneIDs: [String]) {
        print("AdColony initializer")
    }
    func requestAd() {
        
    }
    func isEqual(to anotherAdNetwork: VideoAdNetwork) -> Bool {
        return true
    }
}
