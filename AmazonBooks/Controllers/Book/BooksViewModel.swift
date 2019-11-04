//
//  BooksViewModel.swift
//  AmazonBooks
//
//  Created by Victor Chang on 12/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation
import UIKit

class BooksViewModel {
    
    var onReorderList: (([Book]) -> Void)?
    var onBooksFetched: (([Book]) -> Void)?
    var onSegmentChanged: (([Book]) -> Void)?
    var onLayoutChanged: (() -> Void)?
    
    var books = [Book]()
    var filteredBooks = [Book]()
    var isAscending: Bool = true

    var segmentControl = 0

    var isListView: Bool = true
    
    func cellLayoutChanged(indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: ( UIScreen.main.bounds.width), height: 130)
            if !isListView {
               size = CGSize(width: ( UIScreen.main.bounds.width - 10 )/2, height: 130)
            }
        self.onLayoutChanged?()
        return size
    }
    
    func filterBooks() {
        switch segmentControl {
        case 0:
            self.filteredBooks = self.books
        case 1:
            filteredBooks = books.filter({ return ($0.isAvailable ?? true)})
        case 2:
            filteredBooks = books.filter({ return !($0.isAvailable ?? true) })
        default:
            return
        }
        onBooksFetched?(filteredBooks)
//        onSegmentChanged?(filteredBooks)
    }
    
    func getBooks() {
        Service.shared.fetchBooks { (booksResult, error) in
            if let books = booksResult {
                self.books = books
                self.onBooksFetched?(books)
            }
        }
    }
    
    func arrangeOrder( books: [Book]){
//        var orderedBooks = books
        if isAscending {
            self.filteredBooks = books.sorted(by: { $0.popularity ?? 0 > $1.popularity ?? 0 })
            isAscending = false
            print("isAscending: \(isAscending)")
        } else if !isAscending {
            self.filteredBooks = books.sorted(by: { $0.popularity ?? 0 < $1.popularity ?? 0 })
            isAscending = true
            print("isAscending: \(isAscending)")
        }
//        images.sorted(by: { $0.fileID > $1.fileID })
        self.onReorderList?(filteredBooks)
    }
}
