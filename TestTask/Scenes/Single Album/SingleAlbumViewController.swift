//
//  SingleAlbumViewController.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import UIKit
import SnapKit
import Kingfisher

protocol SingleAlbumDisplayLogic {
    func showSingleAlbum(_ vm: SingleAlbumModel.FetchAlbum.ViewModel)
}

final class SingleAlbumViewController: UIViewController {
    var collectionView: UICollectionView?
    var interactor: SingleAlbumBusinessLogic?
    var router: (NSObject & SingleAlbumPageDataPassing)?
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
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
extension SingleAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shownImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: shownImages[indexPath.row].thumbnailUrl))
        imageView.contentMode = .scaleToFill
        cell.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(shownImages[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension SingleAlbumViewController: SingleAlbumDisplayLogic {
    func showSingleAlbum(_ vm: SingleAlbumModel.FetchAlbum.ViewModel) {
        self.shownImages = vm.images
        collectionView?.reloadData()
    }
}
