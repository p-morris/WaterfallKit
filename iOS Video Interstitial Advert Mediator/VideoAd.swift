//
//  VideoAd.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import UIKit

/// Provides callbacks for interstatial advert events.
@objc protocol VideoAdDelegate {
    /**
     Executed after the interstatial becomes visible.
     
     - Parameters:
     - ad: The `VideoAd` responsible for the callback.
     */
    @objc optional func videoAdDidAppear(_ ad: VideoAd)
    /**
     Executed after the interstatial has been fully dismissed and is no long visible.
     
     - Parameters:
     - ad: The `VideoAd` responsible for the callback.
     */
    @objc optional func videoAdDidDismiss(_ ad: VideoAd)
    /**
     Executed when presenting the video ad modally has failed.
     
     - Parameters:
     - ad: The `VideoAd` responsible for the callback.
     */
    @objc optional func videoAdDidFailToPresent(_ ad: VideoAd)
    /**
     Executed when the interstatial advert is clicked. Depending on the
     advert, this may cause a context shift to another application, and the
     client being moved into the background.
     
     - Parameters:
     - ad: The `VideoAd` responsible for the callback.
     */
    @objc optional func videoAdDidReceiveClick(_ ad: VideoAd)
}

/// An interstital video advert.
@objc protocol VideoAd {
    /// The object that acts as the delegate of the `VideoAd`.
    var delegate: VideoAdDelegate? { get set }
    /**
     Presents the interstial advert modally from the specified `UIViewController`.
     
     - Parameters:
     - from: The `UIViewController` that the interstatial advert should be presented from.
     */
    func display(from viewController: UIViewController)
}
