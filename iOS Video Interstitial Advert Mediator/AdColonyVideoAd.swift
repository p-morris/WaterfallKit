//
//  AdColonyVideoAd.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 30/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used for displaying and invoking delegate callbacks for AdColony interstial videos ads.
class AdColonyVideoAd: VideoAd {
    weak var delegate: VideoAdDelegate?
    /// The AdColony interstial advert
    private let interstitial: AdColonyInterstitial
    /**
     Initializes a new `AdColonyVideoAd` object.
     
     - Parameters:
     - interstitial: The `AdColonyInterstital` advert object to display.
     - Returns: An initialized `AdColonyVideoAd` object.
     */
    init(interstitial: AdColonyInterstitial) {
        self.interstitial = interstitial
        configureCallbacks(for: interstitial)
    }
    /**
     Configures an `AdColonyInterstitial` advert to make delegate callbacks
     for open, close, and click events.
     
     - Parameters:
     - interstitial: The `AdColonyInterstitial` advert object to configure.
     */
    private func configureCallbacks(for interstitial: AdColonyInterstitial) {
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
     
     - Parameters:
     - viewController: The `UIViewController` from which the advert should be modally presented.
     */
    func display(from viewController: UIViewController) {
        interstitial.show(withPresenting: viewController)
    }
}
