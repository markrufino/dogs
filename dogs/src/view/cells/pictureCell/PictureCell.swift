//
//  PictureCell.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Kingfisher

class PictureCell: UITableViewCell {
    
    var imageURL: URL? {
        didSet {
            roundedImageView.kf.setImage(with: imageURL)
        }
    }

    private let roundedImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension PictureCell {
    func setup() {
        roundedImageView.contentMode = .scaleAspectFill
        roundedImageView.layer.cornerRadius = 30
        roundedImageView.clipsToBounds = true
        
        contentView.addSubview(roundedImageView)
        
        roundedImageView.fillSuperview(padding: .allSides(16))
        let heightConstraint = roundedImageView
            .heightAnchor
            .constraint(equalTo: roundedImageView.widthAnchor)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }
}
