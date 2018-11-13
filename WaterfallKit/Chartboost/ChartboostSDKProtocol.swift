//
//  ChartboostSDKProtocol.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

protocol ChartboostSDKProtocol {
    static func setPIDataUseConsent(_ consent: CBPIDataUseConsent)
    static func setLoggingLevel(_ loggingLevel: CBLoggingLevel)
    static func cacheInterstitial(_ location: String!)
    static func start(withAppId appId: String!, appSignature: String!, delegate: ChartboostDelegate!)
}

extension Chartboost: ChartboostSDKProtocol { }

protocol ChartboostAdProtocol {
    static func setDelegate(_ del: ChartboostDelegate!)
    static func showInterstitial(_ location: String!)
}

extension Chartboost: ChartboostAdProtocol { }
