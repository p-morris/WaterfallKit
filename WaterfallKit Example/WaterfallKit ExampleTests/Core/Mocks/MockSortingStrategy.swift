//
//  MockSortingStrategy.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 07/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

import XCTest
@testable import WaterfallKit

class MockSortingStrategy: SortingStrategy {
    var used = false
    func sorted(_ array: [VideoAd]) -> [VideoAd] {
        used = true
        return array
    }
}
