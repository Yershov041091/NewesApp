//
//  NewsResponseObject.swift
//  NewsApp
//
//  Created by Artem Yershov on 15.08.2023.
//

import Foundation

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
