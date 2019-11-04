//
//  BookDetailViewController.swift
//  AmazonBooks
//
//  Created by Victor Chang on 14/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var book: Book? {
        didSet {
            setupBooks()
        }
    }
    
    let titleLabel = UILabel(text: "Book Name", font: .boldSystemFont(ofSize: 25), color: .white, numberOfLines: 1)
    
    let authorLabel = UILabel(text: "Author Label", font: .systemFont(ofSize: 18, weight: .semibold), color: .white, numberOfLines: 0)
    
    let imageView = UIImageView(cornerRadius: 5)
    
    let ratingLabel = UILabel(text: "Rating", font: .systemFont(ofSize: 16, weight: .regular), color: .white, numberOfLines: 1)
    let availabilityLabel = UILabel(text: "Disponible / No Disponible", font: .systemFont(ofSize: 16, weight: .medium), color: .white, numberOfLines: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = book?.name
//        navigationController?.navigationBar.prefersLargeTitles = true

        self.view.backgroundColor = UIColor(white: 0.3, alpha: 1)
        setupUIComponents()
        
    }
    
    fileprivate func setupUIComponents() {
//        view.addSubview(titleLabel)
//        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
//        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        // set image height proportionally to view height
        imageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
//        imageView.backgroundColor = UIColor(white: 0.7, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        
        let stackView = VerticalStackView(arrangedSubviews: [
            authorLabel, ratingLabel, availabilityLabel
        ])
        stackView.spacing = 10
        stackView.alignment = .leading
        view.addSubview(stackView)
        stackView.anchor(top: imageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20 , paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

        
//        view.addSubview(authorLabel)
//        authorLabel.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        view.addSubview(ratingLabel)
//        ratingLabel.anchor(top: authorLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        view.addSubview(availabilityLabel)
//        availabilityLabel.anchor(top: ratingLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    fileprivate func setupBooks() {
        self.titleLabel.text = book?.name
        self.authorLabel.text = book?.author
        self.ratingLabel.text = "Rating: \(book?.popularity ?? 0)"
        if book?.isAvailable ?? false {
            self.availabilityLabel.text = "Disponible"
        } else {
            self.availabilityLabel.text = "No Disponible"
        }
        if book?.imageUrl != "" {
            let url = book?.imageUrl
            let imageUrl = URL(string: url!)
            self.imageView.sd_setImage(with: imageUrl, completed: nil)
        } else if book?.imageUrl == ""{
            self.imageView.image = UIImage(named: "noBookImage")
        }
    }
    
}
