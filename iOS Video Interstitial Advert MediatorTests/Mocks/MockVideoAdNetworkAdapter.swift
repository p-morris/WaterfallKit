//
//  MockVideoAdNetworkAdapter.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockVideoAdNetworkAdapter: VideoAdNetworkAdapter {
    required init?(type: VideoAdNetworkSettings.NetworkType) {
        switch type {
        case .test: self.priority = 9999999
        default: return nil
        }
    }
    weak var delegate: VideoAdNetworkAdapterDelegate?
    var priority: Int
    func requestAd() { }
    func isEqual(to anotherAdNetwork: VideoAdNetworkAdapter) -> Bool { return priority == 9999999 }
}
