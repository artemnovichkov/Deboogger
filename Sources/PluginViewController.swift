//
//  PluginViewController.swift
//  Deboogger
//
//  Created by Nikita Ermolenko on 22/04/2017.
//  Copyright © 2017 Nikita Ermolenko. All rights reserved.
//

import UIKit

final class PluginViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    fileprivate var plugins: [Plugin]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.topViewController!.preferredStatusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return UIApplication.topViewController!.prefersStatusBarHidden
    }

    init(plugins: [Plugin]) {
        self.plugins = plugins
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        plugins.forEach { plugin in
            self.tableView.register(plugin.nib, forCellReuseIdentifier: plugin.cellIdentifier)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(closeButtonPressed))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: Actions
    
    @objc private func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate

extension PluginViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: - UITableViewDataSource

extension PluginViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let plugin = plugins[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: plugin.cellIdentifier, for: indexPath)
        plugin.configureCell(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plugins.count
    }
}