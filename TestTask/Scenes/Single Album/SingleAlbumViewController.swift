//
//  SingleAlbumViewController.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import UIKit
import SnapKit
import Kingfisher
import INSPhotoGallery

protocol SingleAlbumDisplayLogic: class  {
    func showSingleAlbum(_ vm: SingleAlbumModel.FetchAlbum.ViewModel)
    func showDBInteractionButton(isSaved: Bool)
}

final class SingleAlbumViewController: UIViewController {
    // Private
    private var itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    private var saveButton: UIBarButtonItem?
    private var collectionView: UICollectionView?
    private var isSaved: Bool?
    
    
    // Public
    var interactor: SingleAlbumBusinessLogic?
    var router: (NSObjectProtocol & SingleAlbumPageDataPassing & SingleAlbumRoutingLogic)?
    var shownImages = [SingleAlbumImage]()
    
    init(isSaved: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isSaved = isSaved
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
        
        self.interactor?.fetchSingleAlbum(isSaved!)
    }
    
    private func setup() {
        let viewController = self
        let interactor = SingleAlbumInteractor()
        let presenter = SingleAlbumPresentor()
        let router = SingleAlbumRouter()

        viewController.router = router
        viewController.interactor = interactor
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.dataStore = interactor
    }
    
    deinit {
        print("DEINITED")
    }
}

// MARK: - UI
extension SingleAlbumViewController {
    private func setupUI() {
        view.addSubview(collectionView!)
        
        collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        self.navigationItem.rightBarButtonItem = saveButton
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
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let currPhoto = INSPhoto(imageURL: URL(string: shownImages[indexPath.row].url), thumbnailImageURL: URL(string: shownImages[indexPath.row].thumbnailUrl))
        currPhoto.attributedTitle = NSAttributedString(string: shownImages[indexPath.row].title)
        let galleryPreview = INSPhotosViewController(photos: [currPhoto], initialPhoto: currPhoto, referenceView: cell)
        galleryPreview.referenceViewForPhotoWhenDismissingHandler = { photo in
            return collectionView.cellForItem(at: indexPath)
        }
        present(galleryPreview, animated: true, completion: nil)
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
    
    @objc
    func saveToLocalDB() {
        self.interactor?.saveToLocalDB(self.shownImages)
    }
    
    @objc
    func deleteFromLocalDB() {
        self.interactor?.deleteFromLocalDB()
    }
}

// MARK: - DisplayLogic Inher.
extension SingleAlbumViewController: SingleAlbumDisplayLogic {
    func showSingleAlbum(_ vm: SingleAlbumModel.FetchAlbum.ViewModel) {
        self.shownImages = vm.images
        collectionView?.reloadData()
    }
    
    func showDBInteractionButton(isSaved: Bool) {
        if isSaved {
            self.saveButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteFromLocalDB))
        } else {
            self.saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveToLocalDB))
        }
        self.navigationItem.rightBarButtonItem = saveButton
    }
}
