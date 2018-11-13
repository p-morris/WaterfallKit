//
//  AdColonySDKProtocol.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import AdColony

protocol AdColonySDKProtocol {
    static func configure(withAppID appID: String,
                          zoneIDs: [String],
                          options: AdColonyAppOptions?,
                          completion: (([AdColonyZone]) -> Void)?)
    static func requestInterstitial(inZone zoneID: String,
                                    options: AdColonyAdOptions?,
                                    success: @escaping (AdColonyInterstitial) -> Void,
                                    failure: ((AdColonyAdRequestError) -> Void)?)
}

extension AdColony: AdColonySDKProtocol { }

protocol AdColonyInterstitialProtocol {
    func setOpen(_ open: (() -> Void)?)
    func setClose(_ close: (() -> Void)?)
    func setClick(_ click: (() -> Void)?)
    func show(withPresenting viewController: UIViewController) -> Bool
}

extension AdColonyInterstitial: AdColonyInterstitialProtocol { }
