//
//  VungleSDKProtocol.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 07/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import UIKit

protocol VungleSDKProtocol: NSObjectProtocol {
    var delegate: VungleSDKDelegate? { get set }
    func start(withAppId: String) throws
    func loadPlacement(withID: String) throws
}

extension VungleSDK: VungleSDKProtocol { }

protocol VungleAdProtocol: NSObjectProtocol {
    var delegate: VungleSDKDelegate? { get set }
    func playAd(_ controller: UIViewController, options: [AnyHashable: Any]?, placementID: String?) throws
}

extension VungleSDK: VungleAdProtocol { }
