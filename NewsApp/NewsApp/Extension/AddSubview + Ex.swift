//
//  AddSubview + Ex.swift
//  NewsApp
//
//  Created by Artem Yershov on 11.08.2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
