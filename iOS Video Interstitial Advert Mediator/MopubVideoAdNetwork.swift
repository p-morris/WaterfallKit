//
//  MopubVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

class MopubVideoAdNetwork: VideoAdNetwork {
    weak var delegate: VideoAdNetworkDelegate?
    init(adUnitID: String) {
        print("Mopub initializer")
    }
    func requestAd() {
        
    }
    func isEqual(to anotherAdNetwork: VideoAdNetwork) -> Bool {
        return true
    }
}
