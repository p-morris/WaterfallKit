//
//  MockVungleSDK.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 07/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockVungleSDK: NSObject, VungleSDKProtocol, VungleAdProtocol {
    var shouldThrowStartException = false
    var shouldStart = false
    var shouldThrowLoadPlacementException = false
    var shouldLoadPlacement = true
    weak var delegate: VungleSDKDelegate?
    var started = false
    var loadPlacementCalled = false
    var adPlayed = true
    var throwPlayException = false
    func start(withAppId: String) throws {
        if shouldThrowStartException {
            throw NSError(domain: "", code: 0, userInfo: nil)
        } else {
            started = true
            if shouldStart {
                delegate?.vungleSDKDidInitialize?()
            }
        }
    }
    func loadPlacement(withID: String) throws {
        loadPlacementCalled = true
        if shouldThrowLoadPlacementException {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
    }
    func playAd(_ controller: UIViewController, options: [AnyHashable: Any]?, placementID: String?) throws {
        adPlayed = true
        if throwPlayException {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
    }
}
