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
    static weak var testDelegate: ChartboostTestDelegate?
    static func setPIDataUseConsent(_ consent: CBPIDataUseConsent) {
        MockChartboostSDK.testDelegate?.consentSet = true
    }
    static func setLoggingLevel(_ loggingLevel: CBLoggingLevel) {
        MockChartboostSDK.testDelegate?.loggingLevelSet = true
    }
    static func cacheInterstitial(_ location: String!) {
        MockChartboostSDK.testDelegate?.cachedInterstitial = true
    }
    static func start(withAppId appId: String!, appSignature: String!, delegate: ChartboostDelegate!) {
        MockChartboostSDK.testDelegate?.started = true
    }
}

extension MockChartboostSDK: ChartboostAdProtocol {
    static func setDelegate(_ del: ChartboostDelegate!) {
        MockChartboostSDK.testDelegate?.delegateSet = true
    }
    static func showInterstitial(_ location: String!) {
        MockChartboostSDK.testDelegate?.showInterstitial = true
    }
}
