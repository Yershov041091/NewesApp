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
    private var viewModel: BussinesViewModelProtocol

    //MARK: - LifeCycle
    
    init(viewModel: BussinesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setUpViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        collectionView.register(DitailesCollectionViewCell.self, forCellWithReuseIdentifier: "DitailesCollectionViewCell")
    
        viewModel.loadData()
    }
    //MARK: - Methods
    
    func setUpViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.reloadCell = { [weak self] row in
            self?.collectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
        }
        viewModel.showError = { error in
            print(error)
        }
    }
    
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
        if viewModel.numberOfCell > 1 {
            return section == 0 ? 1 : viewModel.numberOfCell - 1
        }
        return viewModel.numberOfCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfCell > 1 ? 2 : 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell
            
            let article = viewModel.getArticle(for: 0)
            cell?.set(article: article)
            
            return cell ?? UICollectionViewCell()
            
        } else {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DitailesCollectionViewCell", for: indexPath) as? DitailesCollectionViewCell
        
            let article = viewModel.getArticle(for: indexPath.row + 1)
            cell?.set(article: article)
            
            return cell ?? UICollectionViewCell()
        }
    }
}
extension BusinessViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let article = viewModel.getArticle(for: indexPath.section == 0 ? 0 : indexPath.row + 1)
        navigationController?.pushViewController(DetaileViewController(viewModel: DetaileViewModel(article: article)), animated: true)
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
