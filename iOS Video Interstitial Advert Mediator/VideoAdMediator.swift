//
//  VideoAdMediator.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Provides callbacks for waterfalled VideoMediator requests
@objc protocol VideoAdMediatorDelegate {
    /**
     Executed when the mediator successfully loads a prioritized video ad.
     
     - Parameters:
     - mediator: The `VideoAdMediator` responsible for the callback.
     - advert: A `VideoAd` object ready for display.
     */
    func mediator(_ mediator: VideoAdMediator, didLoad adverts: [VideoAd])
    /**
     Executed when the mediator successfully loads a prioritized video ad.
     
     - Parameters:
     - mediator: The `VideoAdMediator` responsible for the callback.
     - error: An `Error` that occured.
     */
    func mediator(_ mediator: VideoAdMediator, loadFailedWith error: Error)
}

/// Used for parsing a set of ad networks and requesting adverts.
@objc class VideoAdMediator: NSObject {
    /// The prioritized network settings to use for this ad request
    let settings: VideoAdNetworkSettings
    /// The factory used to create ad network instances
    private let factory: VideoAdNetworkFactory
    /// The object that acts as the delegate of `VideoAdMediator`
    weak var delegate: VideoAdMediatorDelegate?
    /// Number of network requests currently in process
    private var pendingAdNetworkRequests: [VideoAdNetwork] = [] {
        didSet {
            if pendingAdNetworkRequests.count == 0 {
                notifyDelegate()
            }
        }
    }
    /// Adverts ready for display
    private var adverts: [VideoAd] = []
    /// Indicates whether ad requests are currently pending
    var adRequestsPending: Bool {
        return pendingAdNetworkRequests.count > 0
    }
    /**
     Initializes a new `VideoAdMediator` object.
     
     - Parameters:
     - settings: The network settings for the ad networks to be used for ad requests.
     - factory: The `AdNetworkFactory` to be used to instantiate ad networks.
     - Returns: An initialized `VideoAdMediator` object that will use `settings`
     to request appropraite ads as prioritized.
     */
    init(settings: VideoAdNetworkSettings, factory: VideoAdNetworkFactory = InterstitialVideoAdNetworkFactory()) {
        self.settings = settings
        self.factory = factory
    }
    /**
     Iterates through the networks stored in the `VideoAdNetworkSettings` object and
     requests fill for video interstitatial adverts.
     */
    func requestAds() {
        guard !adRequestsPending else { return }
        settings.networkTypes.forEach {
            var network = factory.createAdNetwork(type: $0)
            pendingAdNetworkRequests.append(network)
            network.delegate = self
            network.requestAd()
        }
    }
    /**
     Invokes appropriate callback on `delegate`.
     */
    private func notifyDelegate() {
        guard !adRequestsPending else { return }
        if adverts.count > 0 {
            delegate?.mediator(self, didLoad: adverts)
            adverts.removeAll()
        } else {
            let error = NSError(domain: "VideoAdMediatorNoFillErrorDomain", code: -1, userInfo: nil)
            delegate?.mediator(self, loadFailedWith: error)
        }
    }
}

extension VideoAdMediator: VideoAdNetworkDelegate {
    func adNetwork(_ adNetwork: VideoAdNetwork, didLoad advert: VideoAd) {
        adverts.append(advert)
        pendingAdNetworkRequests.remove(network: adNetwork)
    }
    func adNetwork(_ adNetwork: VideoAdNetwork, didFailToLoad error: Error) {
        pendingAdNetworkRequests.remove(network: adNetwork)
    }
}
