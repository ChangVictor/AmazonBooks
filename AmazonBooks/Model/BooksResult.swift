//
//  BooksResult.swift
//  AmazonBooks
//
//  Created by Victor Chang on 06/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

struct BooksResult: Decodable {
    let result: [Book]
}

struct Book: Decodable {
    var id: Int?
    var name: String?
    var author: String?
    var isAvailable: Bool?
    var popularity: Int?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "nombre"
        case author = "autor"
        case isAvailable = "disponibilidad"
        case popularity = "popularidad"
        case imageUrl = "imagen"
    }
    
    public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.author = try? container.decode(String.self, forKey: .author)
        self.isAvailable = try? container.decode(Bool.self, forKey: .isAvailable)
        self.popularity = try? container.decode(Int.self, forKey: .popularity)
        self.imageUrl = try? container.decode(String.self, forKey: .imageUrl)
    }
}
