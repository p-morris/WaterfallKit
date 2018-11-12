//
//  TableViewController.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 12/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import UIKit

final class TableViewController: UITableViewController {
    typealias AdNetwork = VideoAdNetworkSettings.NetworkType
    /// The reuseID to use for dequeing table view cells
    let reuseID: String
    /// The video ad settings object
    private var adSettings: VideoAdNetworkSettings
    /**
     Initializes a `TableViewController` object.
     
     - Parameters:
     - settings: The `VideoAdNetworkSettings` to use for loading adverts.
     - reuseID: The ID for to use for reusing table view cells..
     */
    init(settings: VideoAdNetworkSettings, reuseID: String = "network-cell") {
        self.adSettings = settings
        self.reuseID = reuseID
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
    }
    /// Not using storyboards or xibs
    required init?(coder aDecoder: NSCoder) {
        adSettings = VideoAdNetworkSettings()
        reuseID = ""
        super.init(coder: aDecoder)
    }
    /// Sets up the navigation title and item
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Networks"
        let item = UIBarButtonItem(title: "Load Ads", style: .plain, target: self, action: #selector(loadAds))
        navigationItem.setRightBarButton(item, animated: false)
    }
    /// Waterfalls requests to ad networks initialized via the `adSettings` object
    @objc func loadAds() {
        let advertController = AdvertTableViewController(adLoader: VideoAdLoader(settings: adSettings))
        navigationController?.pushViewController(advertController, animated: true)
    }
}

/// UITableViewDataSource
extension TableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adSettings.networkTypes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) else {
            fatalError("Unable to dequeue cell with ID: \(reuseID)")
        }
        let network = adSettings.networkTypes[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = network.name
        return cell
    }
}
