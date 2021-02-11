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

        navigationAlbumsVC.tabBarItem = UITabBarItem(title: "All albums", image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book.fill"))
        albumsVC.title = "All albums"
        albumsLocalVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        albumsLocalVC.title = "Favourites"
        locationVC.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "location"), selectedImage: UIImage(systemName: "location.fill"))
        let controllers = [navigationAlbumsVC, navigationAlbumsLocalVC, locationVC]
        self.viewControllers = controllers
    }
}
