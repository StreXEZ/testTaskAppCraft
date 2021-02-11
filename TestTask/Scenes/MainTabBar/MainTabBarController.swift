//
//  MainTabBarController.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.tabBar.isTranslucent = false
        self.selectedIndex = 0
    }
    
    func setupUI() {
        let albumsVC = AlbumsViewController()
        let navigationAlbumsVC = UINavigationController(rootViewController: albumsVC)
        let albumsLocalVC = SavedAlbumsViewController()
        let navigationAlbumsLocalVC = UINavigationController(rootViewController: albumsLocalVC)
        let locationVC = LocationViewController()
        
        navigationAlbumsVC.navigationBar.isTranslucent = false
        navigationAlbumsLocalVC.navigationBar.isTranslucent = false

        navigationAlbumsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        albumsVC.title = "All albums"
        albumsLocalVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        albumsLocalVC.title = "Favourites"
        locationVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        let controllers = [navigationAlbumsVC, navigationAlbumsLocalVC, locationVC]
        self.viewControllers = controllers
    }
}
