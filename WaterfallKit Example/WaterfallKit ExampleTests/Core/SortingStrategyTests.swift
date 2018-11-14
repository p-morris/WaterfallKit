//
//  SortingStrategyTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 07/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import WaterfallKit

class SortingStrategyTests: XCTestCase {
    func testSorting() {
        let adverts = self.adverts()
        let strategy = AscendingPrioritySorting()
        let sortedAds = strategy.sorted(adverts)
        XCTAssert(sortedAds[0].priority == 1 &&
                  sortedAds[1].priority == 2 &&
                  sortedAds[2].priority == 3 &&
                  sortedAds[3].priority == 4)
    }
    func adverts() -> [VideoAd] {
        let adverts = [MockAd(), MockAd(), MockAd(), MockAd()]
        var priority = 1
        adverts.forEach {
            $0.priority = priority
            priority += 1
        }
        return adverts.shuffled()
    }
}
