//
//  GeneralCollectionViewCell.swift
//  NewsApp
//
//  Created by Artem Yershov on 09.08.2023.
//

import Foundation
import UIKit
import SnapKit

final class GeneralCollectionViewCell: UICollectionViewCell {
    
    //MARK: - GUI Variables
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "image") ?? UIImage.add
        image.sizeToFit()
        
        return image
    }()
    private lazy var blackView: UIView = {
       let view = UIView()
        
        view.backgroundColor = .black
        view.alpha = 0.5 // делаем полупрозрачный фон
        
        return view
    }()
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.text = "Title"
        
        return label
    }()
    
    //MARK: - Initialisations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Private Methods
    
    private func setUpUI() {
        addSubview(imageView)
        addSubview(blackView)
        addSubview(titleLable)
        
        addConstraints()
    }
    private func addConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        blackView.snp.makeConstraints { make in
            make.top.equalTo(140)
            make.leading.trailing.bottom.equalToSuperview()
        }
        titleLable.snp.makeConstraints { make in
            make.top.bottom.equalTo(blackView)
            make.leading.trailing.equalTo(blackView).offset(5)
        }
    }
}
