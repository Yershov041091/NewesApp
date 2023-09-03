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
    private var viewModel: NewaListViewModelProtocol

    //MARK: - LifeCycle
    
    init(viewModel: NewaListViewModelProtocol) {
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
    
        viewModel.loadData(searchText: nil)
    }
    //MARK: - Methods
    
    func setUpViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.reloadCell = { [weak self] indexPath in
            self?.collectionView.reloadItems(at: [indexPath])
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
        viewModel.sections[section].items.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell
            
            cell?.set(article: article)
            
            return cell ?? UICollectionViewCell()
            
        } else {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DitailesCollectionViewCell", for: indexPath) as? DitailesCollectionViewCell
        
            cell?.set(article: article)
            
            return cell ?? UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegat
extension BusinessViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel else { return }
        navigationController?.pushViewController(DetaileViewController(viewModel: DetaileViewModel(article: article)), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.sections[1].items.count - 15 {
            viewModel.loadData(searchText: nil)
        }
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
