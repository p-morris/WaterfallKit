//
//  MockAd.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import WaterfallKit

class MockAd: VideoAd {
    weak var delegate: VideoAdDelegate?
    let networkName = "Test"
    var priority: Int = 0
    func display(from viewController: UIViewController, or keyWindow: UIWindow) {
        //
    }
}
