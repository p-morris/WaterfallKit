//
//  AdmobTestDelegate.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 09/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
@testable import WaterfallKit
//swiftlint:disable weak_delegate

class AdmobTestDelegate {
    var configured = false
    var didSetDelegate = false
    var loaded = false
    var presentedFrom: UIViewController?
}
