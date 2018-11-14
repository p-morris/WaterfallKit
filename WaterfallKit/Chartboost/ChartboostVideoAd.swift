//
//  ChartboostVideoAd.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 31/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used for displaying and invoking delegate callbacks for Chartboost interstial videos ads.
final class ChartboostVideoAd: NSObject, VideoAd {
    /// The Chartboost SDK
    private var chartboostSDK: ChartboostAdProtocol.Type
    /// The object that acts as the delegate of the `ChartboostVideoAd`.
    weak var delegate: VideoAdDelegate?
    /// The priority of the ad for display purposes
    var priority = 0
    public let networkName = "Chartboost"
    /**
     Initializes a new `ChartboostVideoAd` object.
     
     - Parameters:
     - chartboostDSK: A type which conforms to `ChartboostAdProtocol` for making ad presentation requests.
     - Returns: An initialized `ChartboostVideoAd`.
     */
    init(chartboostSDK: ChartboostAdProtocol.Type = Chartboost.self) {
        self.chartboostSDK = chartboostSDK
        super.init()
    }
    /**
     Displays the Chartboost interstial ad modally.
     - Note: The implementation details are private for Chartboost interstitials. It can't be
     guaranteed which controller the interstitial will be presented from, or whether it will be
     rendered over the top of the `keyWindow`.
     */
    func display(from viewController: UIViewController, or keyWindow: UIWindow) {
        chartboostSDK.setDelegate(self)
        chartboostSDK.showInterstitial(CBLocationDefault)
    }
}
/// Used to implement delegate callbacks for Chartboost SDK display events
extension ChartboostVideoAd: ChartboostDelegate {
    func didDisplayInterstitial(_ location: String!) {
        delegate?.videoAdDidAppear?(self)
    }
    func didDismissInterstitial(_ location: String!) {
        delegate?.videoAdDidDismiss?(self)
    }
    func didClickInterstitial(_ location: String!) {
        delegate?.videoAdDidReceiveClick?(self)
    }
}
