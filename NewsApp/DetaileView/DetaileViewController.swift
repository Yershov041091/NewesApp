//
//  DetaileViewController.swift
//  NewsApp
//
//  Created by Artem Yershov on 11.08.2023.
//

import Foundation
import UIKit

final class DetaileViewController: UIViewController {
    
    //MARK: - GUI Properties
    private lazy var scrollView: UIScrollView = {
       let view = UIScrollView()
        
        return view
    }()
    private lazy var contentView: UIView = {
       let view = UIView()
        
        return view
    }()
    private let imageView: UIImageView = {
       let image = UIImageView()
        
        image.image = UIImage(named: "image") ?? UIImage.add
        image.sizeToFit()
        
        return image
    }()
    private let titleLabel: UILabel = {
       let label = UILabel()
        
        label.text = "Example Text"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        
        return label
    }()
    private let descriptionLable: UILabel = {
       let label = UILabel()
        
        label.numberOfLines = 0
        label.text = "Picture description is a written caption that describes the essential information in an image. Picture descriptions can define photos, graphics, gifs, and video — basically anything containing visual information."
        label.textColor = .systemGray
        label.font = .italicSystemFont(ofSize: 15)
        label.textAlignment = .left
        
        return label
    }()
    private let dateLabel: UILabel = {
       let label = UILabel()
        
        label.text = String("\(Date.now.formatted(date: .abbreviated, time: .omitted))")
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    //MARK: - Properties
    
    
    //MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    //MARK: - Private func
    
    private func setUpUI() {
        scrollView.addSubview(contentView)
        contentView.addSubviews(views: [imageView, titleLabel, descriptionLable, dateLabel])
        view.addSubview(scrollView)
        view.backgroundColor = .white
        
        setUpConstraints()
    }
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
            make.height.equalToSuperview().inset(5)
        }
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(view.snp.width)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        descriptionLable.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(descriptionLable.snp.bottom).offset(20)
        }
    }
}

