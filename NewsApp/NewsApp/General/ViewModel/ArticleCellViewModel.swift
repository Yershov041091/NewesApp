//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Artem Yershov on 15.08.2023.
//

import Foundation

final class ArticleCellViewModel: TableCollectionViewItemProtocol {
    let title: String
    let description: String
    let date: String
    let imagUrl: String
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        date = article.date
        imagUrl = article.urlToImage
    }
}
