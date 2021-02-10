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
        self.selectedIndex = 0
    }
    
    func setupUI() {
        let albumsVC = AlbumsViewController()
        let navigationAlbumsVC = UINavigationController(rootViewController: albumsVC)
        let albumsLocalVC = AlbumsViewController()
        let locationVC = LocationViewController()

        navigationAlbumsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        albumsVC.title = "All albums"
        albumsLocalVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        locationVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        let controllers = [navigationAlbumsVC, albumsLocalVC, locationVC]
        self.viewControllers = controllers
    }
}