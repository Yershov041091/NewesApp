//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Artem Yershov on 15.08.2023.
//

import Foundation

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    
    var numberOfCells: Int {
        articles.count
    }
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    var reloadCell: ((Int) -> Void)?
    
    //MARK: Properties
    
    private var articles : [ArticleCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    init() {
        loadData()
        }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articles[row]
    }
    
    private func loadData() {
        
        ApiManager.getNews { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.articles = convertToCellViewModel(articles)
                self.loadImage()
            case .failure(let error):
                //TODO: -
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        articles.map { ArticleCellViewModel(article: $0) }
    }
    private func loadImage() {
        for (index, article) in articles.enumerated() {
            ApiManager.getImageData(url: article.imagUrl) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    private func setUpMockObjects() {
        articles = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "War in Ukraine", description: "This articles about Russian invasion bla bla blab labla bl ab la", urlToImage: "...", date: "24.02.2022"))
        ]
    }
}
