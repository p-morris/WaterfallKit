//
//  VideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

@objc protocol VideoAdNetwork {
    /// The object that acts as the delegate of the `VideoAdNetwork`.
    var delegate: VideoAdNetworkDelegate? { get set }
    /**
     Sends a request to the ad network for a advert.
     */
    func requestAd()
}

/// Provides callbacks for AdNetwork request events.
@objc protocol VideoAdNetworkDelegate {
    /**
     Executed when the ad network request is fulfilled.
     
     - Parameters:
     - adNetwork: The `VideoAdNetwork` responsible for the callback.
     - ad: A `VideoAd` object ready for display.
     */
    func adNetwork(_ adNetwork: VideoAdNetwork, didLoad ad: VideoAd)
    /**
     Executed when the ad network request either fails, or is unfulfilled.
     
     - Parameters:
     - adNetwork: The `VideoAdNetwork` responsible for the callback.
     - error: An `Error` representing the problem that occured.
     */
    func adNetwork(_ adNetwork: VideoAdNetwork, didFailToLoad error: Error)
}
