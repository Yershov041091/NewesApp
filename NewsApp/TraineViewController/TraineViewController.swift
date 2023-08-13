//
//  TraineViewController.swift
//  NewsApp
//
//  Created by Artem Yershov on 12.08.2023.
//

import Foundation
import UIKit
import SnapKit

final class TraineViewController: UIViewController {
    
    //MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
       let view = UIImageView()
        
        view.image = UIImage(named: "image") ?? UIImage.add
        view.layer.cornerRadius = 20
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = .init(width: 10, height: 10)
        view.layer.shadowColor = UIColor.black.cgColor
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Example Text"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let width = (view.frame.width - 15) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    //MARK: - Private func
    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubviews(views: [imageView, titleLabel, collectionView])
        
        collectionView.register(TraineCollectionViewCell.self, forCellWithReuseIdentifier: "TraineCollectionViewCell")
        
        setUpConstraints()
    }
    private func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(view.frame.height / 2)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
extension TraineViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TraineCollectionViewCell", for: indexPath) as? TraineCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
extension TraineViewController: UICollectionViewDelegate {
    
}
