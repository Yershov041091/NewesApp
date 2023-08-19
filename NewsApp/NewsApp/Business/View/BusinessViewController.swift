//
//  BusinessViewController.swift
//  NewsApp
//
//  Created by Artem Yershov on 08.08.2023.
//

import Foundation
import UIKit

final class BusinessViewController: UIViewController {
    
    // MARK: - GUI Variabels
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    //MARK: - Properties
    

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        collectionView.register(DitailesCollectionViewCell.self, forCellWithReuseIdentifier: "DitailesCollectionViewCell")
        
        setUpUI()
    }
    //MARK: - Methods
    
    
    //MARK: - Private Methods
    private func setUpUI() {
        view.addSubview(collectionView)
        
        view.backgroundColor = .white
        setUpConstraints()
    }
    private func setUpConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
}
extension BusinessViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : 15
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell?
        
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell
        } else {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DitailesCollectionViewCell", for: indexPath) as? DitailesCollectionViewCell
        }
        return cell ?? UICollectionViewCell()
    }
}
extension BusinessViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        navigationController?.pushViewController(DetaileViewController(), animated: true)
    }
}
extension BusinessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let firstSectionItemSize = CGSize(width: width, height: width)
        let secondSectionItemSize = CGSize(width: width, height: 100)
        
        return indexPath.section == 0 ? firstSectionItemSize : secondSectionItemSize
    }
}
