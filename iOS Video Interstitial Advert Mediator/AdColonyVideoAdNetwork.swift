//
//  AdColonyVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used for making interstitial video ad requests to the AdColony network
class AdColonyVideoAdNetwork: TimeOutableVideoAdNetwork {
    /// The timer used to timeout the request if no response is received.
    /// - Note: Required to a bug with the AdColony SDK where completion isn't made when
    /// provided app ID is invalid.
    let timeoutTimer: TimeOutTimer
    /// The object that acts as the delegate of the `AdColonyVideoAdNetwork`.
    weak var delegate: VideoAdNetworkDelegate?
    /// The priority of the network's ads for display purposes
    var priority = 0
    /// The zone ID to request an advert for
    private let zoneID: String
    /// Indicates whether the AdColony SDK is ready to make ad requests.
    /// - Note: Executes a pending ad request if one was made before the AdColony SDK
    /// became ready to make requests.
    private var ready = false {
        didSet {
            if pendingAdRequest {
                pendingAdRequest = false
                requestAd()
            }
        }
    }
    /// Indicates whether an ad request was received before the AdColony SDK
    /// was ready to make requests.
    private var pendingAdRequest = false
    /**
     Initializes a new `AdColonyVideoAdNetwork` object.
     
     - Parameters:
     - appID: The AdColony app ID to use for ad requests.
     - zoneID: The AdColony zone ID to use for ad requests.
     - Returns: An initialized `AdColonyVideoAdNetwork` object.
     */
    init(appID: String, zoneID: String) {
        self.zoneID = zoneID
        self.timeoutTimer = TimeOutTimer(timeOutIn: 5)
        configure(appID: appID, zoneIDs: [zoneID])
    }
    /**
     Initializes the AdColony SDK.
     
     - Parameters:
     - appID: The AdColony app ID to use for ad requests.
     - zoneID: The AdColony zone ID to use for ad requests.
     */
    private func configure(appID: String, zoneIDs: [String]) {
        let options = AdColonyAppOptions()
        options.disableLogging = true
        timeoutTimer.startTimeOut(notify: self)
        AdColony.configure(withAppID: appID, zoneIDs: zoneIDs, options: options) { _ in
            self.timeoutTimer.cancelTimeOut()
            self.ready = true
        }
    }
    /**
     Makes an interstitial video ad request using the AdColony SDK.
     - Note: If the AdColony SDK is not yet initialized at the time of invocation,
     the request will be enqueued for execution when the AdColony SDK is ready. Only one
     request may be enqueued at a time.
     */
    func requestAd() {
        guard ready else {
            pendingAdRequest = true
            return
        }
        AdColony.requestInterstitial(inZone: zoneID, options: nil, success: { (interstitial) in
            self.delegate?.adNetwork(self, didLoad: AdColonyVideoAd(interstitial: interstitial))
        }, failure: { (error) in
            self.delegate?.adNetwork(self, didFailToLoad: error)
        })
    }
    /**
     Compares `self` with `anotherAdNetwork`. `AdColonyVideoAdNetwork` objects are considered
     equal if they have an equal `zoneID` property.
     - Parameters:
     - anotherAdNetwork: the `VideoAdNetwork` object to compare for equality.
     */
    func isEqual(to anotherAdNetwork: VideoAdNetwork) -> Bool {
        guard let anotherAdNetwork = anotherAdNetwork as? AdColonyVideoAdNetwork else { return false }
        return self.zoneID == anotherAdNetwork.zoneID
    }

}
