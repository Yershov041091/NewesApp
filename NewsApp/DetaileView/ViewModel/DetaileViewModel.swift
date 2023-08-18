//
//  DetaileViewModel.swift
//  NewsApp
//
//  Created by Artem Yershov on 18.08.2023.
//

import Foundation

protocol DetaileViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var date: String { get }
    var imageData: Data? { get }
}

final class DetaileViewModel: DetaileViewModelProtocol {
    let title: String
    let description: String
    let date: String
    let imageData: Data?
    
    init(article: ArticleCellViewModel) {
        title = article.title
        description = article.description
        date = article.date
        imageData = article.imageData
    }
}
