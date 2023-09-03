//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Artem Yershov on 27.08.2023.
//

import Foundation

protocol NewaListViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var sections: [TableCollectionViewSection] { get }
    
    func loadData(searchText: String?)

}

class NewsListViewModel: NewaListViewModelProtocol {
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    var reloadCell: ((IndexPath) -> Void)?
    
    //MARK: - Properties
    
    var sections: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    var searchText: String? = nil
    
    var page = 0
    
    // MARK: Methods
    func loadData(searchText: String? = nil) {
        
        if self.searchText != searchText {
            page = 1
        } else {
            page += 1
        }
        self.searchText = searchText
    }
    
    
    func handleResult(_ result: Result<[ArticleResponseObject], Error>) {
        switch result {
        case .success(let articles):
            self.convertToCellViewModel(articles)
            self.loadImage()
        case .failure(let error):
            DispatchQueue.main.async {
                self.showError?(error.localizedDescription)
            }
        }
    }
    
    func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        let viewModels = articles.map { ArticleCellViewModel(article: $0) }
        
        if sections.isEmpty {
            let firstSection = TableCollectionViewSection(items: viewModels)
            sections = [firstSection]
        } else {
            sections[0].items += viewModels
        }
    }
    private func loadImage() {
        for (i, section) in sections.enumerated() {
            for (index, item) in section.items.enumerated() {
                if let article = item as? ArticleCellViewModel {
                    
                    let url = article.imagUrl
                    ApiManager.getImageData(url: url) { [weak self] result in
                        
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                if let article = self?.sections[i].items[index] as? ArticleCellViewModel {
                                    article.imageData = data
                                }
                                self?.reloadCell?(IndexPath(row: index, section: i))
                            case .failure(let error):
                                self?.showError?(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
}
