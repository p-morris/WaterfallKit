//
//  AdvertTableViewController.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 12/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import UIKit
import WaterfallKit

final class AdvertTableViewController: UITableViewController {

    /// The reuse ID to use for dequeuing table view cells.
    let reuseID: String
    /// The `VideoAdLoader` to use for waterfalling video ad requests.
    private let adLoader: VideoAdLoader?
    /// Loaded adverts which can be displayed
    private var adverts: [VideoAd] = [] {
        didSet {
            refreshControl?.endRefreshing()
            tableView.reloadData()
        }
    }
    /**
     Initializes a `AdvertTableViewController` object.
     
     - Parameters:
     - adLoader: The `VideoAdLoader` to use for waterfalling video ad requests.
     - reuseID: The ID for to use for reusing table view cells..
     */
    init(adLoader: VideoAdLoader, reuseID: String = "advert-cell") {
        self.adLoader = adLoader
        self.reuseID = reuseID
        super.init(nibName: nil, bundle: nil)
        self.adLoader?.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
    }
    /// Required, but not using storyboards
    required init?(coder aDecoder: NSCoder) {
        adLoader = nil
        reuseID = ""
        super.init(coder: aDecoder)
    }
    /// Initializes the navigation title, and refresh control.
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Adverts"
        refreshControl = UIRefreshControl()
        refreshControl?.beginRefreshing()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if adverts.count == 0 {
            load()
        }
    }
    /// Enables the `refreshControl` and loads adverts via the `adLoader` object.
    @objc func load() {
        adLoader?.requestAds()
    }
}

extension AdvertTableViewController: VideoAdLoaderDelegate {
    func adLoader(_ adLoader: VideoAdLoader, didLoad adverts: [VideoAd]) {
        self.adverts = adverts
    }
    /// Ads failed to load. Presents an error alert and retries when it's dismissed.
    func adLoader(_ adLoader: VideoAdLoader, loadFailedWith error: Error) {
        tableView.refreshControl?.endRefreshing()
        let alert = UIAlertController(title: "Failed to load adverts.", message: "Tap to retry", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.refreshControl?.beginRefreshing()
            self.load()
        }))
        //present(alert, animated: true, completion: nil)
    }
}

/// UITableViewDataSource
extension AdvertTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adverts.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tap advert to play:"
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) else {
            fatalError("Unable to dequeue tableViewCell with ID \(reuseID)")
        }
        let advert = adverts[indexPath.row]
        cell.textLabel?.text = advert.networkName
        return cell
    }
}

/// UITableViewDelegate
extension AdvertTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let window = UIApplication.shared.keyWindow {
            let advert = adverts[indexPath.row]
            advert.delegate = self
            advert.display(from: self, or: window)
        }
    }
}

extension AdvertTableViewController: VideoAdDelegate {
    func videoAdDidDismiss(_ advert: VideoAd) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}

extension VideoAd {
    var networkName: String {
        switch self {
        case is VungleVideoAd: return "Vungle"
        case is ChartboostVideoAd: return "Chartboost"
        case is AdMobVideoAd: return "AdMob"
        case is AppLovinVideoAd: return "AppLovin"
        case is AdColonyVideoAd: return "AdColony"
        default: return "Test"
        }
    }
}
