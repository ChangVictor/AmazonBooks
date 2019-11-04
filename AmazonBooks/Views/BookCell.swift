//
//  BookCell.swift
//  AmazonBooks
//
//  Created by Victor Chang on 06/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {
    
    var book: Book? {
        didSet {
            setCellValues()
        }
    }
    
    let imageView = UIImageView(cornerRadius: 5)
    
    let titleLabel = UILabel(text: "Book Name", font: .boldSystemFont(ofSize: 15), color: .white, numberOfLines: 0)
    
    let authorLabel = UILabel(text: "Author Label", font: .systemFont(ofSize: 14), color: .white, numberOfLines: 2)
    
    let ratingLabel = UILabel(text: "Rating: 0", font: .systemFont(ofSize: 13), color: .white)
    
    let availabilityLabel = UILabel(text: "AvailabilityLabel", font: .systemFont(ofSize: 12), color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.image = UIImage.init(named: "noBookImage")
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [
        imageView,
        VerticalStackView(arrangedSubviews: [titleLabel, authorLabel, ratingLabel, availabilityLabel], spacing: 4)
        ], customSpacing: 16)

        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 16, bottom: 10, right: 16))
        stackView.alignment = .top
    }
    
    fileprivate func setCellValues() {
        self.titleLabel.text = book?.name
        self.authorLabel.text = book?.author
        if book?.isAvailable ?? false {
            self.availabilityLabel.text = "Disponible"
        } else {
            self.availabilityLabel.text = "No Disponible"
        }
        self.ratingLabel.text = "Rating: \(book?.popularity ?? 0)"
        if book?.imageUrl != "" {
            let url = book?.imageUrl
            let imageUrl = URL(string: url!)
            self.imageView.sd_setImage(with: imageUrl, completed: nil)
        } else if book?.imageUrl == ""{
            self.imageView.image = UIImage(named: "noBookImage")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
