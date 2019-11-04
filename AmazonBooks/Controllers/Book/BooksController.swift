//
//  BooksController.swift
//  AmazonBooks
//
//  Created by Victor Chang on 06/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit
import SDWebImage

class BooksController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    var books = [Book]()

    let booksViewModel = BooksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupNavigationStyle()
        setupNavButtons()
//         fix header on view
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    fileprivate func setupViewModel() {
        booksViewModel.getBooks()
        booksViewModel.onBooksFetched = { [unowned self] books in
            self.books = books
            self.reloadData()
        }
        booksViewModel.onReorderList = { [unowned self] books in
            self.books = books
            self.reloadData()
        }

    }
    
    fileprivate func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupNavButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "grid")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLayoutButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSortButton))
        
    }
    
    @objc fileprivate func handleSortButton() {
        print("handle Sort Button")
        booksViewModel.arrangeOrder(books: self.books)
    }
    
    @objc fileprivate func handleLayoutButton() {
        print("layout button pressed")
//        presenter.isListView = !presenter.isListView
        booksViewModel.isListView = !booksViewModel.isListView
        print("isListView: \(booksViewModel.isListView)")
        self.reloadData()
        
    }
    
    fileprivate func setupNavigationStyle() {
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BooksController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
        header.onSegmentChange = { [unowned self] segmentIndex in
            // filter bookList
            self.booksViewModel.segmentControl = segmentIndex
            self.booksViewModel.filterBooks()
            print(segmentIndex, self.booksViewModel.segmentControl)
            self.reloadData()
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 40)
    }
}

extension BooksController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookCell
        cell.book = books[indexPath.item]

        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.booksViewModel.cellLayoutChanged(indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookDetailController = BookDetailViewController()
        bookDetailController.book = self.books[indexPath.item]
//        self.present(bookDetailController, animated: true, completion: nil)
        self.navigationController?.pushViewController(bookDetailController, animated: true)
    }
}

