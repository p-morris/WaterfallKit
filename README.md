# WaterfallKit
## Get 100% Fill Rate for iOS Interstitial Video adverts

### Table of Contents

- [Introduction](#introduction)
- [Installing WaterfallKit](#installing-waterfallkit)
- [Initializing WaterfallKit](#initializing-waterfallkit)
- [Requesting Adverts](#requesting-adverts)
- [Displaying Adverts](#displaying-adverts)
- [VideoAd Callbacks](#videoad-callbacks)
- [Issues and Requests](#issues-and-requests)

## Introduction

Waterfall kit helps you to prioritize and waterfall requests for interstitial video adverts. You should be able to achieve a 100% advert fill rate using WaterfallKit.

Currently, WaterfallKit supports AdColony, AppLovin and Admob interstital video adverts. Support for more networks will be added in the future.

## Installing WaterfallKit

### Cocoapods (Recommended)

You can install support for each advertising network you wish to use.

For AdColony:

`pod 'WaterfallKit/AdColony'`

For AppLovin:

`pod 'WaterfallKit/AppLovin'`

For AdMob:

`pod 'WaterfallKit/AdMob'`

Or, you can simply install the entire library, which will include files for all advertising networks that are currently supported:

`pod 'WaterfallKit'`

### Manual installation

This method is not recommended, because it involves independently setting up each advertising network's SDK in your Xcode project.

1) Clone the repository.
2) Open the `WaterfallKit` folder and add the `Core` folder to your Xcode project.
3) Add the folder for each advertising network you want to use to your project.
4) Follow the steps to add the SDK for each advertising network you wish to you to your project:

If you wish to use AdColony, follow the instructions to install the AdColony iOS SDK which can be found here:

https://github.com/AdColony/AdColony-iOS-SDK-3/wiki/Project-Setup

If you wish to use AppLovin, follow the instructions to install the AppLovin iOS SDK which can be found here:

https://dash.applovin.com/docs/integration#iosIntegration

If you wish to use AdMob, follow the instructions to install the AdMob iOS SDK which can be found here:

https://developers.google.com/admob/ios/quick-start

I highly recommend you use Cocoapods instead of following the manual installation process.

## Initializing WaterfallKit

Before you can request and display ads, you need initialize `WaterfallKit` with your account details for the various ad networks you wish to use.

The `VideoAdNetworkSettings` class is used for this purpose.

Initialize a `VideoAdNetworkSettings` object, and then call the `initialize` methods that it provides for each network that you wish to use.

You can chain initialize calls for convenience.

```
let networkSettings = VideoAdNetworkSettings()
.initializeAdMob(
    appID: "{AdMob AppID Goes Here}",
    adUnitID: "AdMob Ad Unit Goes Here"
).initializeAppLovin(
    sdkKey: "AppLovin SDK Key Goes Here"
).initializeAdColony(
    appID: "AdColony AppID Goes Here",
    zoneID: "AdColony ZoneID Goes Here"
)
```

Note: The order in which you initialize networks determines the priority for each network.

In the above example, AdMob ads will be prioritized ahead of AppLovin ads. AdColony ads are judged to be the lowest priority.

Call the initialization methods in the order you wish the ads to be prioritized in, with the highest priority network first.

## Requesting Adverts

The `VideoAdLoader` class is used to make ad requests.

Initialize a `VideoAdLoader` object, passing your `VideoAdNetworkSettings` objects into the initializer, to help the loader prioritize your requests.

```
let loader = VideoAdLoader(settings: networkSettings)
loader.delegate = self
loader.requestAds()
```

## Displaying Adverts

Your client should conform to the `VideoAdLoaderDelegate` protocol and assign itself as the delegate of a `VideoAdLoader` object to receive adverts.

The protocol consists of two methods: `adLoader(_:didLoad:)` and `adLoader(_:loadFailedWithError:)`.

When ads are successfully loaded, the `adLoader(_:didLoad:)` method will be called, and an array of `VideoAd` objects will be provided.

Since the array is ordered by the priority, you can simply access the `first` object, and ask it to display itself:

```
if let window = UIApplication.shared.keyWindow {
    let advert = adverts[indexPath.row]
    dvert.delegate = self
    advert.display(from: self, or: window)
}
```

If the ad loader was unable to load any adverts at all, then an error will be provided via the `adLoader(_:loadFailedWithError:)` methods.

## `VideoAd` Callbacks

Your client should also coform to the `VideoAdDelegate` protocol.

This protocol is used to provide callbacks to your client when adverts display, are dismissed, are clicked, and when an advert fails to display.

All methods in this protocol are optional.

## Issues and requests

If you come across any bugs, or there is a particular advertising network that you'd like to see support added for, then please file a Github issue and I'll get back to you.