//
//  ChartboostVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used for making interstitial video ad requests to the Chartboost network
class ChartboostAdapter: NSObject, TimeOutableVideoAdNetworkAdapter {
    /// The timer used to timeout the request if no response is received.
    /// - Note: Required to a bug with the Chartboost SDK where completion isn't made when
    /// provided app ID is invalid.
    var timeoutTimer: TimeOutTimer
    /// Used to encapsulate `String` literals related to errors loading
    /// Charboost interstitial adverts
    private enum ChartboostAdError {
        static let initializationFailed = "Chartboost SDK failed to initialize"
        static let noFill = "Chartboost failed to load interstitial advert"
    }
    /// The object that acts as the delegate of the `ChartboostVideoAdNetwork`.
    weak var delegate: VideoAdNetworkAdapterDelegate?
    /// The priority of the network's ads for display purposes
    var priority = 0
    /// Indicates whether the Chartboost SDK is ready to make ad requests.
    /// - Note: Executes a pending ad request if one was made before the Chartboost SDK
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
    /// The Chartboost app ID used to make requests
    private let appID: String
    /// The Chartboost app signature used to make requests
    private let appSignature: String
    /**
     Initializes a new `ChartboostVideoAdNetwork` object.
     
     - Parameters:
     - appID: The Chartboost application ID to use for ad requests.
     - appSignature: The Chartboost app signature to use for ad request.
     - Returns: An initialized `ChartboostVideoAdNetwork` object.
     */
    init(appID: String, appSignature: String) {
        self.appID = appID
        self.appSignature = appSignature
        self.timeoutTimer = TimeOutTimer(timeOutIn: 5)
        super.init()
        timeoutTimer.startTimeOut(notify: self)
        Chartboost.setPIDataUseConsent(.Unknown)
        Chartboost.setLoggingLevel(.off)
        Chartboost.start(withAppId: appID, appSignature: appSignature, delegate: self)
    }
    /**
     Makes an interstitial video ad request using the Chartboost SDK.
     - Note: If the Chartboost SDK is not yet initialized at the time of invocation,
     the request will be enqueued for execution when the Chartboost SDK is ready. Only one
     request may be enqueued at a time.
     */
    func requestAd() {
        guard ready else {
            pendingAdRequest = true
            return
        }
       Chartboost.cacheInterstitial(CBLocationDefault)
    }
    /**
     Compares `self` with `anotherAdNetwork`. `ChartboostVideoAdNetwork` objects are considered
     equal if they have equal `appID`, `appSignature` and `ready` properties.
     - Parameters:
     - anotherAdNetwork: the `VideoAdNetwork` object to compare for equality.
     */
    func isEqual(to anotherAdNetwork: VideoAdNetworkAdapter) -> Bool {
        guard let anotherAdNetwork = anotherAdNetwork as? ChartboostAdapter else { return false }
        return self.appID == anotherAdNetwork.appID
            && self.appSignature == anotherAdNetwork.appSignature
            && self.ready == anotherAdNetwork.ready
    }
}

/// Used to implement delegate callbacks for Chartboost SDK ad loading events
extension ChartboostAdapter: ChartboostDelegate {
    func didInitialize(_ status: Bool) {
        timeoutTimer.cancelTimeOut()
        if status {
            ready = status
        } else {
            pendingAdRequest = false
            let error = NSError(domain: ChartboostAdError.noFill, code: -1, userInfo: nil)
            delegate?.adNetwork(self, didFailToLoad: error)
        }
    }
    func didCacheInterstitial(_ location: String!) {
        delegate?.adNetwork(self, didLoad: ChartboostVideoAd())
    }
    func didFail(toLoadInterstitial location: String!, withError error: CBLoadError) {
        let error = NSError(domain: ChartboostAdError.initializationFailed, code: Int(error.rawValue), userInfo: nil)
        delegate?.adNetwork(self, didFailToLoad: error)
    }
}
