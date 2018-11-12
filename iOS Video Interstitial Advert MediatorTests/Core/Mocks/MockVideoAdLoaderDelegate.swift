//
//  MockVideoAdLoaderDelegate.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockVideoAdLoaderDelegate: VideoAdLoaderDelegate {
    var error: Error?
    var adverts: [VideoAd]?
    func adLoader(_ adLoader: VideoAdLoader, didLoad adverts: [VideoAd]) {
        self.adverts = adverts
    }
    func adLoader(_ adLoader: VideoAdLoader, loadFailedWith error: Error) {
        self.error = error
    }
}
