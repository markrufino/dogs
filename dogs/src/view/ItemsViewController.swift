//
//  ViewController.swift
//  dogs
//
//  Created by Mark Rufino on 10/20/22.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    let dummyViewModel: ItemsViewModel = DogBreedsViewModel()
    
    var didSelectItemAt: ((IndexPath) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.description())
    }

}

// MARK: - DataSource

extension ItemsViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        dummyViewModel.items.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemCell.description(),
            for: indexPath
        ) as? ItemCell else { fatalError("Failed to dequeue cell") }
        
        cell.viewModel = dummyViewModel.items[indexPath.row]
        
        return cell
    }
}

// MARK: - Delegate

extension ItemsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItemAt?(indexPath)
    }
}
