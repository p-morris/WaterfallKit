//
//  VideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used to represent a video ad network
protocol VideoAdNetworkAdapter {
    /// The object that acts as the delegate of the `VideoAdNetwork`.
    var delegate: VideoAdNetworkAdapterDelegate? { get set }
    /// The priority of the network for display purposes
    var priority: Int { get set }
    /**
     Sends a request to the ad network for a advert.
     */
    func requestAd()
    /**
     Tests `anotherAdNetwork` to see if it is the same object as `self`.
     
     - Parameters:
     - anotherAdNetwork: The `VideoAdNetwork` to compare.
     - Returns: `true` is anotherAdNetwork is the same ad network as `self`, `false` otherwise.
     */
    func isEqual(to anotherAdNetwork: VideoAdNetworkAdapter) -> Bool
}

/// Used to add timeout functionality to a video ad network
protocol TimeOutableVideoAdNetworkAdapter: class, VideoAdNetworkAdapter {
    /// The timer used to timeout the request
    var timeoutTimer: TimeOutTimer { get }
    /// Called when the timeout timer fires
    func timeOut()
}

/// Default implementation for TimeOutable
extension TimeOutableVideoAdNetworkAdapter {
    /// The Error domain for a timeout error.
    private var timeOutError: String {
        return "RequestTimedOutErrorDomain"
    }
    /// Notifies the delegate that the timeout has occured
    func timeOut() {
        let error = NSError(domain: timeOutError, code: -1, userInfo: nil)
        delegate?.adNetwork(self, didFailToLoad: error)
    }
}

/// Provides callbacks for AdNetwork request events.
protocol VideoAdNetworkAdapterDelegate: class {
    /**
     Executed when the ad network request is fulfilled.
     
     - Parameters:
     - adNetwork: The `VideoAdNetwork` responsible for the callback.
     - ad: A `VideoAd` object ready for display.
     */
    func adNetwork(_ adapter: VideoAdNetworkAdapter, didLoad advert: VideoAd)
    /**
     Executed when the ad network request either fails, or is unfulfilled.
     
     - Parameters:
     - adNetwork: The `VideoAdNetwork` responsible for the callback.
     - error: An `Error` representing the problem that occured.
     */
    func adNetwork(_ adapter: VideoAdNetworkAdapter, didFailToLoad error: Error)
}

/// Used to add functionality to `Array` where its elements are `VideoAdNetwork` objects.
extension Array where Element == VideoAdNetworkAdapter {
    /**
     Removes the first instance of `network`.

     - Parameters:
     - network: The `VideoAdNetwork` to remove the first instance of.
     */
    func removing(adapter: VideoAdNetworkAdapter) -> Array {
        return filter { !$0.isEqual(to: adapter) }
    }
}
