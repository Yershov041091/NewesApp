//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Artem Yershov on 16.08.2023.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
