//
//  MockVideoAdNetworkAdapter.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockVideoAdNetworkAdapter: VideoAdNetworkAdapter {
    static var staticPriority = 0
    static var delegateSet = false
    static var adRequested = false
    static var shouldFail = false
    static var shouldDelegate = false
    required init?(type: VideoAdNetworkSettings.NetworkType) {
        switch type {
        case .test: self.priority = 0
        default: return nil
        }
    }
    weak var delegate: VideoAdNetworkAdapterDelegate? {
        didSet {
            MockVideoAdNetworkAdapter.delegateSet = true
        }
    }
    var priority: Int {
        didSet {
            MockVideoAdNetworkAdapter.staticPriority = priority
        }
    }
    func requestAd() {
        MockVideoAdNetworkAdapter.adRequested = true
    }
    func isEqual(to anotherAdNetwork: VideoAdNetworkAdapter) -> Bool {
        return anotherAdNetwork is MockVideoAdNetworkAdapter
    }
}

class AnotherMockVideoAdNetworkAdapter: VideoAdNetworkAdapter {
    static var staticPriority = 0
    static var delegateSet = false
    static var adRequested = false
    static var shouldFail = false
    static var shouldDelegate = false
    required init?(type: VideoAdNetworkSettings.NetworkType) {
        switch type {
        case .test: self.priority = 0
        default: return nil
        }
    }
    weak var delegate: VideoAdNetworkAdapterDelegate? {
        didSet {
            MockVideoAdNetworkAdapter.delegateSet = true
        }
    }
    var priority: Int {
        didSet {
            MockVideoAdNetworkAdapter.staticPriority = priority
        }
    }
    func requestAd() {
        MockVideoAdNetworkAdapter.adRequested = true
    }
    func isEqual(to anotherAdNetwork: VideoAdNetworkAdapter) -> Bool {
        return anotherAdNetwork is MockVideoAdNetworkAdapter
    }
}
