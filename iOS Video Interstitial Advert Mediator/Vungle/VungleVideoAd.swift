//
//  VungleVideoAd.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 01/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used for displaying and invoking delegate callbacks for Vungle interstial videos ads.
class VungleVideoAd: NSObject, VideoAd {
    /// The object that acts as the delegate of the `VungleVideoAd`.
    weak var delegate: VideoAdDelegate?
    /// The priority of the ad for display purposes
    var priority = 0
    /// The placementID of the Vungle ad
    let placementID: String
    /// The Vungle SDK
    private let vungleSDK: VungleSDK
    /**
     Initializes a new `VungleVideoAd` object.
     
     - Parameters:
     - placementID: The Vungle placement ID of the ad to display.
     - vungleSDK: The Vungle SDK object to use for displaying the ad.
     - Returns: An initialized `VungleVideoAd` object.
     */
    init(placementID: String, vungleSDK: VungleSDK) {
        self.placementID = placementID
        self.vungleSDK = vungleSDK
    }
    /**
     Displays the Vungle interstial ad modally.
     */
    func display(from viewController: UIViewController, or keyWindow: UIWindow) {
        vungleSDK.delegate = self
        do {
            try vungleSDK.playAd(viewController, options: nil, placementID: placementID)
        } catch {
            delegate?.videoAdDidFailToPresent?(self)
        }
    }
}

/// Used to implement delegate callbacks for Chartboost SDK display events
extension VungleVideoAd: VungleSDKDelegate {
    func vungleWillShowAd(forPlacementID placementID: String?) {
        delegate?.videoAdDidAppear?(self)
    }
    func vungleDidCloseAd(with info: VungleViewInfo, placementID: String) {
        delegate?.videoAdDidDismiss?(self)
    }
}
