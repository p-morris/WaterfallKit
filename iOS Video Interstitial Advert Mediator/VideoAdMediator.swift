//
//  VideoAdMediator.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Provides callbacks for waterfalled VideoMediator requests
@objc protocol VideoAdMediatorDelegate {
    /**
     Executed when the mediator successfully loads a prioritized video ad.
     
     - Parameters:
     - mediator: The `VideoAdMediator` responsible for the callback.
     - advert: A `VideoAd` object ready for display.
     */
    func mediator(_ mediator: VideoAdMediator, didLoad advert: VideoAd)
    /**
     Executed when the mediator successfully loads a prioritized video ad.
     
     - Parameters:
     - mediator: The `VideoAdMediator` responsible for the callback.
     - error: An `Error` that occured.
     */
    func mediator(_ mediator: VideoAdMediator, loadFailedWith error: Error)
}

/// Used for parsing a set of ad networks and requesting adverts.
@objc class VideoAdMediator: NSObject {
    /// The prioritized network settings to use for this ad request
    let settings: VideoAdNetworkSettings
    /// The object that acts as the delegate of `VideoAdMediator`
    weak var delegate: VideoAdMediatorDelegate?
    /**
     Initializes a new `VideoAdMediator` object.
     
     - Parameters:
     - settings: The network settings for the ad networks to be used for ad requests.
     - Returns: An initialized `VideoAdMediator` object that will use `settings` to request appropraite ads as prioritized.
     */
    init(settings: VideoAdNetworkSettings) {
        self.settings = settings
    }
}
