//
//  AppLovinVideoAd.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 30/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import AppLovinSDK

/// Used for displaying and invoking delegate callbacks for AppLovin interstial videos ads.
final class AppLovinVideoAd: NSObject, VideoAd {
    /// The object that acts as the delegate of the `AppLovinVideoAd`.
    weak var delegate: VideoAdDelegate?
    /// The priority of the ad for display purposes
    var priority = 0
    /// The AppLovin advert to display.
    private let appLovinAd: ALAd
    /// The AppLovin interstitial that will be reponsible for rendering the advert.
    private (set) var interstitial: AppLovinInterstitialProtocol
    /**
     Initializes a new `AppLovinVideoAd` object.
     
     - Parameters:
     - appLovinAd: The AppLovin advert object to display.
     - interstitial: The AppLovin interstitial used to render the ad.
     - Returns: An initialized `AppLovinVideoAd` object.
     */
    init(appLovinAd: ALAd, interstitial: AppLovinInterstitialProtocol) {
        self.appLovinAd = appLovinAd
        self.interstitial = interstitial
        super.init()
    }
    /**
     Displays the AppLovin interstial ad modally.
     - Note: AppLovin ads are rendered over the top of `keyWindow`.
     */
    func display(from viewController: UIViewController, or keyWindow: UIWindow) {
        interstitial.adDisplayDelegate = self
        interstitial.showOver(keyWindow, andRender: appLovinAd)
    }
}

/// Used to implement delegate callbacks for AppLovin SDK display events
extension AppLovinVideoAd: ALAdDisplayDelegate {
    func ad(_ advert: ALAd, wasDisplayedIn view: UIView) {
        delegate?.videoAdDidAppear?(self)
    }
    func ad(_ advert: ALAd, wasHiddenIn view: UIView) {
        delegate?.videoAdDidDismiss?(self)
    }
    func ad(_ advert: ALAd, wasClickedIn view: UIView) {
        delegate?.videoAdDidReceiveClick?(self)
    }
}
