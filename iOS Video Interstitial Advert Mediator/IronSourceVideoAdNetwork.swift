//
//  IronSourceVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

class IronSourceVideoAdNetwork: VideoAdNetwork {
    weak var delegate: VideoAdNetworkDelegate?
    init(appKey: String) {
        print("IronSource initializer")
    }
    func requestAd() {
        print("IronSource Ad Requested")
    }
}
