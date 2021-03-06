//
//  AdMobVideoAd.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 31/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import GoogleMobileAds

/// Used for displaying and invoking delegate callbacks for Admob interstial videos ads.
final class AdMobVideoAd: NSObject, VideoAd {
    /// The object that acts as the delegate of the `AdMobVideoAd`.
    weak var delegate: VideoAdDelegate?
    /// The priority of the ad for display purposes
    var priority = 0
    /// The `GADInterstitial` which contains the ad to be displayed.
    private (set) var interstitial: AdMobAdProtocol
    public let networkName = "AdMob"
    /**
     Initializes a new `AdMobVideoAd` object.
     
     - Parameters:
     - interstitial: The `GADInterstitial` which contains the ad to be displayed.
     - Returns: An initialized `AdMobVideoAd` object.
     */
    init(interstitial: AdMobAdProtocol) {
        self.interstitial = interstitial
        super.init()
    }
    /**
     Displays the Admob interstial ad modally.
     - Note: Admob ads are presented from the `rootViewController` property of `keyWindow`, or
     from `viewController` if that fails.
     */
    func display(from viewController: UIViewController, or keyWindow: UIWindow) {
        interstitial.delegate = self
        interstitial.present(fromRootViewController: keyWindow.rootViewController ?? viewController)
    }
}

/// Used to implement delegate callbacks for Admob SDK display events
extension AdMobVideoAd: GADInterstitialDelegate {
    func interstitialWillPresentScreen(_ advert: GADInterstitial) {
        delegate?.videoAdDidAppear?(self)
    }
    func interstitialDidFail(toPresentScreen advert: GADInterstitial) {
        delegate?.videoAdDidFailToPresent?(self)
    }
    func interstitialDidDismissScreen(_ advert: GADInterstitial) {
        delegate?.videoAdDidDismiss?(self)
    }
    func interstitialWillLeaveApplication(_ advert: GADInterstitial) {
        delegate?.videoAdDidReceiveClick?(self)
    }
}
