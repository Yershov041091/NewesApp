//
//  TabBarController.swift
//  NewsApp
//
//  Created by Artem Yershov on 19.08.2023.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewControllers()
        setUpTabBar()
    }
    
    private func setUpViewControllers() {
        viewControllers = [
            setUpNavigationController(rootViewController: GeneralViewController(viewModel: GeneralViewModel()), title: "General", image: UIImage(systemName: "newspaper") ?? UIImage.add),
            setUpNavigationController(rootViewController: BusinessViewController(), title: "Business", image: UIImage(systemName: "briefcase") ?? UIImage.add),
            setUpNavigationController(rootViewController: TechnologyViewController(), title: "Technology", image: UIImage(systemName: "gyroscope") ?? UIImage.add),
        ]
    }
    private func setUpNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
    private func setUpTabBar() {
        let appirience = UITabBarAppearance()
        appirience.configureWithOpaqueBackground()
        tabBar.scrollEdgeAppearance = appirience
        
        view.tintColor = .black
    }
}
