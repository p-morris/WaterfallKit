//
//  AdMobVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import GoogleMobileAds

/// Used for making interstitial video ad requests to the Admob network
class AdMobVideoAdNetwork: NSObject, VideoAdNetworkAdapter {
    /// The object that acts as the delegate of the `AdMobVideoAdNetwork`.
    weak var delegate: VideoAdNetworkAdapterDelegate?
    /// The priority of the network's ads for display purposes
    var priority = 0
    /// The `GADInterstitial` responsible for displaying the advert.
    let interstitial: GADInterstitial
    /// The `GADRequest` responsible for loading the advert.
    private let request: GADRequest
    /**
     Initializes a new `AdMobVideoAdNetwork` object.
     
     - Parameters:
     - appID: The Admob application ID to use for ad requests.
     - adUnitID: The Admob ad unit ID to use for ad request.
     - request: The `GADRequest` to use for loading ads.
     - Returns: An initialized `AdMobVideoAdNetwork` object.
     */
    init(appID: String, adUnitID: String, request: GADRequest = GADRequest()) {
        GADMobileAds.configure(withApplicationID: appID)
        interstitial = GADInterstitial(adUnitID: adUnitID)
        self.request = request
    }
    /// Makes an interstitial video ad request using the Admob SDK.
    func requestAd() {
        interstitial.delegate = self
        interstitial.load(request)
    }
    /**
     Compares `self` with `anotherAdNetwork`. `AdMobVideoAdNetwork` objects are considered
     equal if they have an equal `interstitial` property.
     - Parameters:
     - anotherAdNetwork: the `VideoAdNetwork` object to compare for equality.
     */
    func isEqual(to anotherAdNetwork: VideoAdNetworkAdapter) -> Bool {
        guard let anotherAdNetwork = anotherAdNetwork as? AdMobVideoAdNetwork else { return false }
        return interstitial == anotherAdNetwork.interstitial
    }
}

/// Used to implement delegate callbacks for Admob SDK ad loading events
extension AdMobVideoAdNetwork: GADInterstitialDelegate {
    func interstitialDidReceiveAd(_ advert: GADInterstitial) {
        delegate?.adNetwork(self, didLoad: AdMobVideoAd(interstitial: advert))
    }
    func interstitial(_ advert: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        delegate?.adNetwork(self, didFailToLoad: error)
    }
}
