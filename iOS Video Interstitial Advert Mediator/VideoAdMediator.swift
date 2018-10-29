//
//  VideoAdMediator.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Provides callbacks for waterfalled VideoMediator requests
@objc protocol VideoAdMediatorDelegate {
    /**
     Executed when the mediator successfully loads a prioritized video ad.
     
     - Parameters:
     - mediator: The `VideoAdMediator` responsible for the callback.
     - ad: A `VideoAd` object ready for display.
     */
    func mediator(_ mediator: VideoAdMediator, didLoad ad: VideoAd)
    func mediator(_ mediator: VideoAdMediator, loadFailedWith error: Error)
}

@objc class VideoAdMediator: NSObject {
    
}
