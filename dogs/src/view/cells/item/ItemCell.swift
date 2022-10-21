//
//  DogBreedCell.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import LBTATools

class ItemCell: UITableViewCell {
    
    var viewModel: ItemCellViewModel? {
        didSet {
            setupViewModel()
        }
    }
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup

private extension ItemCell {
    func setup() {
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 6
        contentView.addSubview(mainStack)
        mainStack.fillSuperview(padding: .init(
            top: 20,
            left: 16,
            bottom: 20,
            right: 16
        ))
        
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .systemGray2
        
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(subtitleLabel)
        
        accessoryType = .disclosureIndicator
    }
    
    func setupViewModel() {
        titleLabel.text = viewModel?.title
        
        if let subtitle = viewModel?.subtitle {
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = false
        } else {
            subtitleLabel.isHidden = true
        }
    }
}
