//
//  MockAdColonyInterstitial.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
@testable import WaterfallKit

class MockAdColonyInterstitial: AdColonyInterstitialProtocol {
    var didSetOpen = false
    var didSetClose = false
    var didSetClick = false
    var didShow = false
    func setOpen(_ open: (() -> Void)?) {
        didSetOpen = true
        open?()
    }
    func setClose(_ close: (() -> Void)?) {
        didSetClose = true
        close?()
    }
    func setClick(_ click: (() -> Void)?) {
        didSetClick = true
        click?()
    }
    func show(withPresenting viewController: UIViewController) -> Bool {
        didShow = true
        return true
    }
}
