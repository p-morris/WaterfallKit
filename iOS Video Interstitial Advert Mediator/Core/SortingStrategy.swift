//
//  SortingStrategy.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 07/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

protocol SortingStrategy {
    func sorted(_ array: [VideoAd]) -> [VideoAd]
}

class AscendingPrioritySorting: SortingStrategy {
    func sorted(_ array: [VideoAd]) -> [VideoAd] {
        return array.sorted { $0.priority < $1.priority }
    }
}
