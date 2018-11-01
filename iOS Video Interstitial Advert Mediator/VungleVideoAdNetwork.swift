//
//  VungleVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used for making interstitial video ad requests to the Vungle network
class VungleVideoAdNetwork: NSObject, VideoAdNetwork {
    /// The object that acts as the delegate of the `ChartboostVideoAdNetwork`.
    weak var delegate: VideoAdNetworkDelegate?
    /// The priority of the network's ads for display purposes.
    var priority = 0
    /// The Vungle application ID.
    let appID: String
    /// The Vungle placement ID.
    let placementID: String
    /// The Vungle SDK
    let vungleSDK: VungleSDK
    /// Indicates whether the Vungle SDK is ready to make ad requests.
    /// - Note: Executes a pending ad request if one was made before the Vungle SDK
    /// became ready to make requests.
    private (set) var ready: Bool? {
        didSet {
            if pendingAdRequest {
                requestAd()
            }
        }
    }
    /// Indicates whether an ad request was received before the Vungle SDK
    /// was ready to make requests.
    private var pendingAdRequest = false
    /**
     Initializes a new `VungleVideoAdNetwork` object.
     
     - Parameters:
     - appID: The Vungle application ID to use for ad requests.
     - placementID: The Vungle placement ID to use for ad request.
     - vungleSDK: The Vungle SDK object to use for the ad request.
     - Returns: An initialized `VungleVideoAdNetwork` object.
     */
    init(appID: String, placementID: String, vungleSDK: VungleSDK = VungleSDK.shared()) {
        self.appID = appID
        self.placementID = placementID
        self.vungleSDK = vungleSDK
        super.init()
        start(sdk: vungleSDK, appID: appID)
    }
    /**
     Starts the Vungle SDK using a given application ID.
     
     - Parameters:
     - sdk: The Vungle sdk to start.
     - appID: The Vungle app ID to use for ad requests.
     */
    private func start(sdk: VungleSDK, appID: String) {
        do {
            vungleSDK.delegate = self
            try vungleSDK.start(withAppId: appID)
        } catch {
            ready = false
        }
    }
    /**
     Makes an interstitial video ad request using the Vungle SDK.
     - Note: If the Vungle SDK is not yet initialized at the time of invocation,
     the request will be enqueued for execution when the Vungle SDK is ready. Only one
     request may be enqueued at a time.
     */
    func requestAd() {
        guard let ready = ready else {
            pendingAdRequest = true
            return
        }
        guard ready else {
            let error = NSError(domain: "VunglesdkInitializationFailed", code: -1, userInfo: nil)
            delegate?.adNetwork(self, didFailToLoad: error)
            return
        }
        do {
            try vungleSDK.loadPlacement(withID: placementID)
        } catch {
            self.ready = false
            delegate?.adNetwork(self, didFailToLoad: error)
        }
    }
    /**
     Compares `self` with `anotherAdNetwork`. `VungleVideoAdNetwork` objects are considered
     equal if they have equal `appID`, `placementID` and `ready` properties.
     - Parameters:
     - anotherAdNetwork: the `VideoAdNetwork` object to compare for equality.
     */
    func isEqual(to anotherAdNetwork: VideoAdNetwork) -> Bool {
        guard let anotherAdNetwork = anotherAdNetwork as? VungleVideoAdNetwork else { return false }
        return self.appID == anotherAdNetwork.appID
            && self.placementID == anotherAdNetwork.placementID
            && self.ready == anotherAdNetwork.ready
    }
}

/// Used to implement delegate callbacks for Vungle SDK ad loading events
extension VungleVideoAdNetwork: VungleSDKDelegate {
    func vungleSDKDidInitialize() {
        ready = true
    }
    func vungleSDKFailedToInitializeWithError(_ error: Error) {
        ready = false
        delegate?.adNetwork(self, didFailToLoad: error)
    }
    func vungleAdPlayabilityUpdate(_ isAdPlayable: Bool, placementID: String?, error: Error?) {
        guard let ready = ready, ready else { return }
        let advert = VungleVideoAd(placementID: placementID ?? self.placementID, vungleSDK: vungleSDK)
        delegate?.adNetwork(self, didLoad: advert)
    }
}
