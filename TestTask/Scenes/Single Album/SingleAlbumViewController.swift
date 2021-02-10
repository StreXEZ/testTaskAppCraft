//
//  SingleAlbumViewController.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import UIKit
import SnapKit

protocol SingleAlbumDisplayLogic {
    func showSingleAlbum(_ vm: SingleAlbumModel.FetchAlbum.ViewModel)
}

final class SingleAlbumViewController: UIViewController {
    var collectionView: UICollectionView?
    var interactor: SingleAlbumBusinessLogic?
    var router: (NSObject & SingleAlbumPageDataPassing)?
    
    var shownImages = [SingleAlbumImage]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupUI()
        
        self.interactor?.fetchSingleAlbum()
    }
    
    private func setup() {
        let interactor = SingleAlbumInteractor()
        let presenter = SingleAlbumPresentor()
        let router = SingleAlbumRouter()
        
        self.router = router
        router.viewController = self
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
        router.dataStore = interactor
    }
}

// MARK: - UI
extension SingleAlbumViewController {
    private func setupUI() {
        view.addSubview(collectionView!)
        
        collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(saveToLocalDB))
    }
    
    @objc
    func saveToLocalDB() {
        self.interactor?.saveToLocalDB()
    }
}

// MARK: - CollectionView
extension SingleAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shownImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension SingleAlbumViewController: SingleAlbumDisplayLogic {
    func showSingleAlbum(_ vm: SingleAlbumModel.FetchAlbum.ViewModel) {
        self.shownImages = vm.images
        collectionView?.reloadData()
    }
}
