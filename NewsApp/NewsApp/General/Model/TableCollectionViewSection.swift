//
//  TableCollectionViewSection.swift
//  NewsApp
//
//  Created by Artem Yershov on 25.08.2023.
//

import Foundation

protocol TableCollectionViewItemProtocol { }

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemProtocol]
}
