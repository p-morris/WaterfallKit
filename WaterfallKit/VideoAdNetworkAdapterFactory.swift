//
//  VideoAdNetworkAdapterFactory.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 02/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used to instantiate `VideoAdNetwork` instances.
public protocol VideoAdNetworkAdapterFactory {
    /// The array of adapter types that the factory will use for
    /// creation of network adapter objects.
    static var adapterClasses: [VideoAdNetworkAdapter.Type] { get }
    /**
     Registers a concrete adapter class which a `VideoAdNetworkAdapterFactory` will
     use for instantiating `VideoAdNetworkAdapter` objects.
     
     - Parameters:
     - adapterType: The concrete `VideoAdNetworkAdapter` type to register for use.
     */
    static func register<T>(adapterType: T.Type) where T: VideoAdNetworkAdapter
    /**
     Unregisters a concrete adapter class. A `VideoAdNetworkAdapterFactory` will
     not use that class for instantiating `VideoAdNetworkAdapter` objects.
     
     - Parameters:
     - adapterType: The concrete `VideoAdNetworkAdapter` type to register for use.
     */
    static func unregister<T>(adapterType: T.Type) where T: VideoAdNetworkAdapter
    /**
     Unregisters all concrete adapter classes for factory use.
     */
    static func unregisterAllAdapterTypes()
    /**
     Instantiates and returns a concrete `VideoAdNetwork` object using the `NetworkType` it
     receives as an argument.
     
     - Parameters:
     - type: The `NetworkType` to instantiate a `VideoAdNetwork` object for.
     - Returns: An object conforming to `VideoAdNetwork` if one could be created, `nil` otherwise.
     */
    func createAdapter(type: VideoAdNetworkSettings.NetworkType) -> VideoAdNetworkAdapter?
}

/// Used to instantiate `VideoAdNetwork` instances for interstitatial video ads.
public final class InterstitialAdapterFactory: VideoAdNetworkAdapterFactory {
    /// The concrete `VideoAdNetworkAdapter` classes to use to instantiate
    /// `VideoAdNetworkAdapter` objects.
    private (set) public static var adapterClasses: [VideoAdNetworkAdapter.Type] = []
    public init() { }
    public func createAdapter(type: VideoAdNetworkSettings.NetworkType) -> VideoAdNetworkAdapter? {
        var returnAdapter: VideoAdNetworkAdapter?
        for adapterClass in InterstitialAdapterFactory.adapterClasses {
            if let adapter = adapterClass.init(type: type) {
                returnAdapter = adapter
                break
            }
        }
        return returnAdapter
    }
    public static func register<T>(adapterType: T.Type) where T: VideoAdNetworkAdapter {
        adapterClasses.append(adapterType)
    }
    public static func unregister<T>(adapterType: T.Type) where T: VideoAdNetworkAdapter {
        adapterClasses = adapterClasses.filter { !($0 is T.Type) }
    }
    public static func unregisterAllAdapterTypes() {
        adapterClasses.removeAll()
    }
}
