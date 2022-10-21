//
//  PicturesTableViewController.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import UIKit

class PicturesTableViewController: UITableViewController {
    
    private let viewModel: PicturesTableViewModel
    
    init(_ viewModel: PicturesTableViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableView.register(PictureCell.self, forCellReuseIdentifier: PictureCell.description())
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        viewModel.onReloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - DataSource

extension PicturesTableViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.imageURLs.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let pictureCell = tableView.dequeueReusableCell(
            withIdentifier: PictureCell.description(),
            for: indexPath
        ) as? PictureCell else { fatalError("Failed to dequeue cell") }
        
        pictureCell.imageURL = viewModel.imageURLs[indexPath.row]
        
        return pictureCell
    }
    
    override func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        let contentView = UIView()
        
        let button = UIButton(title: "Load Next Page", titleColor: .white)
        button.addAction(.init(handler: { [weak self] _ in
            self?.viewModel.loadNextPage()
        }), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        
        let buttonHeight: CGFloat = 50
        button.withHeight(buttonHeight)
        button.layer.cornerRadius = buttonHeight / 2
        
        contentView.addSubview(button)
        button.fillSuperview(padding: .allSides(16))
        
        return contentView
    }
}
