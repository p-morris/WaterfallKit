//
//  VideoAdLoader.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Provides callbacks for prioritized VideoAdLoader requests
@objc protocol VideoAdLoaderDelegate {
    /**
     Executed when the mediator successfully loads a prioritized video ad.
     
     - Parameters:
     - mediator: The `VideoAdMediator` responsible for the callback.
     - advert: A `VideoAd` object ready for display.
     */
    func mediator(_ mediator: VideoAdLoader, didLoad adverts: [VideoAd])
    /**
     Executed when the mediator successfully loads a prioritized video ad.
     
     - Parameters:
     - mediator: The `VideoAdMediator` responsible for the callback.
     - error: An `Error` that occured.
     */
    func mediator(_ mediator: VideoAdLoader, loadFailedWith error: Error)
}

/// Used for parsing a set of ad networks and requesting adverts.
@objc class VideoAdLoader: NSObject {
    /// Used to encapsulate `String` literals related to errors loading
    /// video ads
    private enum VideoAdLoaderError {
        static let noFill = "VideoAdLoaderNoFill"
    }
    /// The prioritized network settings to use for this ad request
    let settings: VideoAdNetworkSettings
    /// The factory used to create ad network instances
    private let factory: VideoAdNetworkAdapterFactory
    /// The object that acts as the delegate of `VideoAdMediator`
    weak var delegate: VideoAdLoaderDelegate?
    /// Number of network requests currently in process
    private var pendingAdNetworkRequests: [VideoAdNetworkAdapter] = [] {
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
    /// Indicates the number of ad requests still pending
    var numberOfPendingRequests: Int {
        return pendingAdNetworkRequests.count
    }
    /**
     Initializes a new `VideoAdMediator` object.
     
     - Parameters:
     - settings: The network settings for the ad networks to be used for ad requests.
     - factory: The `AdNetworkFactory` to be used to instantiate ad networks.
     - Returns: An initialized `VideoAdMediator` object that will use `settings`
     to request appropraite ads as prioritized.
     */
    init(settings: VideoAdNetworkSettings, factory: VideoAdNetworkAdapterFactory = InterstitialAdapterFactory()) {
        self.settings = settings
        self.factory = factory
    }
    /**
     Iterates through the networks stored in the `VideoAdNetworkSettings` object and
     requests fill for video interstitatial adverts.
     */
    func requestAds() {
        guard !adRequestsPending else { return }
        for (index, networkType) in settings.networkTypes.enumerated() {
            if let network = factory.createAdapter(type: networkType) {
                network.priority = index + 1
                pendingAdNetworkRequests.append(network)
                network.delegate = self
                network.requestAd()
            }
        }
    }
    /**
     Invokes appropriate callback on `delegate`.
     */
    private func notifyDelegate() {
        guard !adRequestsPending else { return }
        if adverts.count > 0 {
            adverts.sort { $0.priority < $1.priority }
            delegate?.mediator(self, didLoad: adverts)
            adverts.removeAll()
        } else {
            let error = NSError(domain: VideoAdLoaderError.noFill, code: -1, userInfo: nil)
            delegate?.mediator(self, loadFailedWith: error)
        }
    }
}

extension VideoAdLoader: VideoAdNetworkAdapterDelegate {
    /**
     Assigns advert priority, ads to the adverts array and removes the pending request.
     */
    func adNetwork(_ adapter: VideoAdNetworkAdapter, didLoad advert: VideoAd) {
        advert.priority = adapter.priority
        adverts.append(advert)
        pendingAdNetworkRequests = pendingAdNetworkRequests.removing(adapter: adapter)
    }
    /**
     Removes the failed pending request.
     */
    func adNetwork(_ adapter: VideoAdNetworkAdapter, didFailToLoad error: Error) {
        pendingAdNetworkRequests = pendingAdNetworkRequests.removing(adapter: adapter)
    }
}
