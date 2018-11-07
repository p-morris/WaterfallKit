//
//  MockAd.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockAd: VideoAd {
    weak var delegate: VideoAdDelegate?
    var priority: Int = 0 {
        didSet {
            MockAd.staticPriority = priority
        }
    }
    static var staticPriority = 0
    func display(from viewController: UIViewController, or keyWindow: UIWindow) {
        //
    }
}
