//
//  VideoAd.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import UIKit

/// An interstital video advert.
@objc public protocol VideoAd {
    /// The object that acts as the delegate of the `VideoAd`.
    var delegate: VideoAdDelegate? { get set }
    /// The priority of ad for display.
    var priority: Int { get set }
    /// The name of the network the ad belongs to
    var networkName: String { get }
    /**
     Presents the interstial advert modally from the specified `UIViewController`, or `UIWindow`.
     
     - Parameters:
     - from: The `UIViewController` that the interstatial advert should be presented from.
     - keyWindow: The key `UIWindow` of the application. Some ad networks require the ad to be
     presented over the window instead of over a view controller.
     */
    func display(from viewController: UIViewController, or keyWindow: UIWindow)
}

/// Provides callbacks for interstatial advert events.
@objc public protocol VideoAdDelegate {
    /**
     Executed after the interstatial becomes visible.
     
     - Parameters:
     - ad: The `VideoAd` responsible for the callback.
     */
    @objc optional func videoAdDidAppear(_ advert: VideoAd)
    /**
     Executed after the interstatial has been fully dismissed and is no long visible.
     
     - Parameters:
     - ad: The `VideoAd` responsible for the callback.
     */
    @objc optional func videoAdDidDismiss(_ advert: VideoAd)
    /**
     Executed when presenting the video ad modally has failed.
     
     - Parameters:
     - ad: The `VideoAd` responsible for the callback.
     */
    @objc optional func videoAdDidFailToPresent(_ advert: VideoAd)
    /**
     Executed when the interstatial advert is clicked. Depending on the
     advert, this may cause a context shift to another application, and the
     client being moved into the background.
     
     - Parameters:
     - ad: The `VideoAd` responsible for the callback.
     */
    @objc optional func videoAdDidReceiveClick(_ advert: VideoAd)
}
