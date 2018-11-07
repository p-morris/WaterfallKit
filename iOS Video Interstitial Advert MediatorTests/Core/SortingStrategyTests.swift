//
//  SortingStrategyTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 07/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class SortingStrategyTests: XCTestCase {

    func testSorting() {
        let ad1 = MockAd()
        ad1.priority = 1
        let ad2 = MockAd()
        ad2.priority = 2
        let ad3 = MockAd()
        ad3.priority = 3
        let ad4 = MockAd()
        ad4.priority = 4
        let ads = [ad3, ad2, ad4, ad1]
        let strategy = AscendingPrioritySorting()
        let sortedAds = strategy.sorted(ads)
        XCTAssert(sortedAds[0].priority == 1 &&
                  sortedAds[1].priority == 2 &&
                  sortedAds[2].priority == 3 &&
                  sortedAds[3].priority == 4)
    }

}
