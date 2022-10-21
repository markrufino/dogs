//
//  ViewController.swift
//  dogs
//
//  Created by Mark Rufino on 10/20/22.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var didSelectItemAt: ((IndexPath) -> Void)?
    
    private let viewModel: ItemsViewModel
    
    private let reloadable: Reloadable?
    
    /// Inject a reloadable object to enable reloading functionality of this screen
    init(_ viewModel: ItemsViewModel, _ reloadable: Reloadable? = nil) {
        self.viewModel = viewModel
        self.reloadable = reloadable
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.description())
        
        viewModel.onReloadData = { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }
        
        if reloadable != nil {
            setupReloader()
        }
    }
    
    private func setupReloader() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Refresh",
            style: .plain,
            target: self,
            action: #selector(reloadScreen)
        )
        
        refreshControl = UIRefreshControl()
        
        refreshControl?.addTarget(self, action: #selector(reloadScreen), for: .valueChanged)
    }

}

// MARK: - DataSource

extension ItemsViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.items.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemCell.description(),
            for: indexPath
        ) as? ItemCell else { fatalError("Failed to dequeue cell") }
        
        cell.viewModel = viewModel.items[indexPath.row]
        
        return cell
    }
}

// MARK: - Delegate

extension ItemsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItemAt?(indexPath)
    }
}

// MARK: - Actions

extension ItemsViewController {
    @objc
    private func reloadScreen() {
        refreshControl?.beginRefreshing()
        reloadable?.reload()
    }
}
