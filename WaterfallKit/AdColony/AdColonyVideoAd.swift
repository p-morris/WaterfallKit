//
//  AdColonyVideoAd.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 30/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import AdColony

/// Used for displaying and invoking delegate callbacks for AdColony interstial videos ads.
final class AdColonyVideoAd: NSObject, VideoAd {
    /// The object that acts as the delegate of the `VideoAdDelegate`.
    weak var delegate: VideoAdDelegate?
    /// The priority of the ad for display purposes
    var priority = 0
    /// The AdColony interstial advert
    private let interstitial: AdColonyInterstitialProtocol
    /**
     Initializes a new `AdColonyVideoAd` object.
     
     - Parameters:
     - interstitial: The `AdColonyInterstital` advert object to display.
     - Returns: An initialized `AdColonyVideoAd` object.
     */
    init(interstitial: AdColonyInterstitialProtocol, delegate: VideoAdDelegate? = nil) {
        self.delegate = delegate
        self.interstitial = interstitial
        super.init()
        configureCallbacks(for: interstitial)
    }
    /**
     Configures an `AdColonyInterstitial` advert to make Cdelegate callbacks
     for open, close, and click events.
     
     - Parameters:
     - interstitial: The `AdColonyInterstitial` advert object to configure.
     */
    private func configureCallbacks(for interstitial: AdColonyInterstitialProtocol) {
        interstitial.setOpen {
            self.delegate?.videoAdDidAppear?(self)
        }
        interstitial.setClose {
            self.delegate?.videoAdDidDismiss?(self)
        }
        interstitial.setClick {
            self.delegate?.videoAdDidReceiveClick?(self)
        }
    }
    /**
     Displays the AdColony interstial ad modally.
     - Note: AdColony ads are presented modally from `viewController`.
     */
    func display(from viewController: UIViewController, or keyWindow: UIWindow) {
        _ = interstitial.show(withPresenting: viewController)
    }
}
