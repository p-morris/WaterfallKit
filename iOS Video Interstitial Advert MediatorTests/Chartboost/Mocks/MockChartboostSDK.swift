//
//  MockChartboostSDK.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockChartboostSDK: ChartboostSDKProtocol {
    static var consentSet = false
    static var loggingLevelSet = false
    static var cachedInterstitial = false
    static var started = false
    static func setPIDataUseConsent(_ consent: CBPIDataUseConsent) {
        consentSet = true
    }
    static func setLoggingLevel(_ loggingLevel: CBLoggingLevel) {
        loggingLevelSet = true
    }
    static func cacheInterstitial(_ location: String!) {
        cachedInterstitial = true
    }
    static func start(withAppId appId: String!, appSignature: String!, delegate: ChartboostDelegate!) {
        started = true
    }
}

extension MockChartboostSDK: ChartboostAdProtocol {
    static var delegateSet = false
    static var showInterstitial = false
    static func setDelegate(_ del: ChartboostDelegate!) {
        delegateSet = true
    }
    static func showInterstitial(_ location: String!) {
        showInterstitial = true
    }
}
