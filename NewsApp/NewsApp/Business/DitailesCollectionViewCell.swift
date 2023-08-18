//
//  DitailesCollectionViewCell.swift
//  NewsApp
//
//  Created by Artem Yershov on 13.08.2023.
//

import UIKit
import SnapKit

final class DitailesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "image") ?? UIImage.add
        view.contentMode = .scaleToFill
        view.layer.masksToBounds = true //картинка не будет выходить за границы
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Title Here"
        label.numberOfLines = 2
        
        return label
    }()
    private lazy var descriprionLabel: UILabel = {
       let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Description for news should be here. Please remove this mock text"
        label.numberOfLines = 2
        
        return label
    }()
    
    //MARK: - LifyCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setUpUI() {
        
        addSubviews(views: [imageView, titleLabel, descriprionLabel])
        
        setUpConstraints()
    }
    private func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.height.equalTo(self.frame.height) //делаем высоту и ширину картинки равной самой ячейке (self это сама ячейка)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(5)
        }
        descriprionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
    }
}
