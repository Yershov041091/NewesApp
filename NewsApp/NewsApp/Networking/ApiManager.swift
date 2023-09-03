//
//  ApiManager.swift
//  NewsApp
//
//  Created by Artem Yershov on 16.08.2023.
//

import Foundation

final class ApiManager {
    enum Category: String {
        case general = "general"
        case business = "business"
        case technology = "technology"
    }
    
    private static let apiKey = "40e158280cbc4512827781fe8247f086"
    private static let baseUrl = "https://newsapi.org/v2/" // основной адрес который не меняется
    private static let path = "top-headlines" // дополнение к адресу которое конкретезирует запрос
    
    //Create url path and make request
    static func getNews(from category: Category,
                        page: Int,
                        searchText: String?,
                        complition: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        var searchParameter = ""
        if let searchText = searchText {
            searchParameter = "q=\(searchText)"
        }
        
        let stringUrl = baseUrl + path + "?category\(category.rawValue)&language=en&page=\(page)" + searchParameter + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            hendleResponse(data: data, error: error, complition: complition)
        }
        
        session.resume() // свойство которое отправляет запрос в интернет
    }
    static func getImageData(url: String, complition: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                complition(.success(data))
            }
            if let error = error {
                complition(.failure(error))
            }
        }
        session.resume()
    }
    //Handle responce
    private static func hendleResponse(data: Data?, error: Error?, complition: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        
        if let error = error {
            complition(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self, from: data)
                
                complition(.success(model.articles))
            } catch {
                complition(.failure(error))
            }
        } else {
            complition(.failure(NetworkingError.unknown))
        }
    }
}
