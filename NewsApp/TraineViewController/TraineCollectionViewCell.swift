//
//  TraineCollectionViewCell.swift
//  NewsApp
//
//  Created by Artem Yershov on 12.08.2023.
//

import Foundation
import UIKit
import SnapKit

final class TraineCollectionViewCell: UICollectionViewCell {
    
    //MARK: - GUI Properties
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "image") ?? UIImage.add
        view.sizeToFit()
        
        return view
    }()
    private lazy var blackView: UIView = {
       let view = UIView()
        
        view.backgroundColor = .black
        view.alpha = 0.5
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        
        label.text = "Traine text"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 5)
        
        return label
    }()
    
    //MARK: - LyfeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func setUpUI() {
        addSubviews(views: [imageView, blackView, titleLabel])
        setUpConstraints()
    }
    private func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        blackView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.top).offset(140)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(blackView)
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
}
