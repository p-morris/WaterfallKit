//
//  VideoAdMediatorDelegate.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 26/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

@objc protocol VideoAdMediatorDelegate {
    func mediator(_ mediator: String, didLoad ad: String)
    func mediator(_ mediator: String, loadFailedWith error: Error)
}
