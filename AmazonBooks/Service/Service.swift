//
//  Service.swift
//  AmazonBooks
//
//  Created by Victor Chang on 06/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    public func fetchBooks( completion: @escaping ([Book]?, Error?) -> Void) {
    
        let urlString = "https://qodyhvpf8b.execute-api.us-east-1.amazonaws.com/test/books"
        fetchData(urlString: urlString, completion: completion)
    }
    
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> () ) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
