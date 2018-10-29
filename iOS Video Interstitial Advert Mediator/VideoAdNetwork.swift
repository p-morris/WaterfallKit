//
//  VideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

@objc protocol AdNetwork {
    /// The object that acts as the delegate of the `AdNetwork`.
    var delegate: AdNetworkDelegate? { get set }
    /**
     Sends a request to the ad network for a advert.
     */
    func requestAd()
}

/// Provides callbacks for AdNetwork request events.
@objc protocol AdNetworkDelegate {
    /**
     Executed when the ad network request is fulfilled.
     
     - Parameters:
     - adNetwork: The `AdNetwork` responsible for the callback.
     - ad: A `VideoAd` object ready for display.
     */
    func adNetwork(_ adNetwork: AdNetwork, didLoad ad: VideoAd)
    /**
     Executed when the ad network request either fails, or is unfulfilled.
     
     - Parameters:
     - adNetwork: The `AdNetwork` responsible for the callback.
     - error: An `Error` representing the problem that occured.
     */
    func adNetwork(_ adNetwork: AdNetwork, didFailToLoad error: Error)
}
