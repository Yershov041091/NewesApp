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
        
        image.contentMode = .scaleToFill
        
        return image
    }()
    private let titleLabel: UILabel = {
       let label = UILabel()
        
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 23)
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    private let descriptionLable: UILabel = {
       let label = UILabel()
        
        label.numberOfLines = 0
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
    private let viewModel: DetaileViewModelProtocol
    
    //MARK: - LyfeCycle
    
    init(viewModel: DetaileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
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
        
        titleLabel.text = viewModel.title
        descriptionLable.text = viewModel.description
        dateLabel.text = viewModel.date
        
        if let data = viewModel.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "image")
        }
        
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
            make.leading.trailing.equalToSuperview().inset(10)
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

