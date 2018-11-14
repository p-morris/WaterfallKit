//
//  MockAdDelegate.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 07/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
//import WaterfallKit

class MockAdDelegate: VideoAdDelegate {
    var didAppear = false
    var didDismiss = false
    var didReceiveClick = false
    var didFailToPresent = false
    func videoAdDidAppear(_ advert: VideoAd) {
        didAppear = true
    }
    func videoAdDidDismiss(_ advert: VideoAd) {
        didDismiss = true
    }
    func videoAdDidReceiveClick(_ advert: VideoAd) {
        didReceiveClick = true
    }
    func videoAdDidFailToPresent(_ advert: VideoAd) {
        didFailToPresent = true
    }
}
