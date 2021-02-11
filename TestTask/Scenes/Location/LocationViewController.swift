//
//  LocationViewController.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//

import UIKit
import SnapKit

protocol LocationDisplayLogic {
    func showUserLocaiton(_ vm: LocationModel.LocationFetch.ViewModel)
    func userLocationIsNotShowing()
}

class LocationViewController: UIViewController {
    var iterator: LocationBusinessLogic?
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 50
        return button
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }
    
    private func setup() {
        let iterator = LocationIterator()
        let presenter = LocationPresenter()
        
        self.iterator = iterator
        iterator.presenter = presenter
        presenter.viewController = self
    }
    
    deinit {
        print("Deinited")
    }
}

// MARK: - UI
extension LocationViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(button)
        view.addSubview(textLabel)
        
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
        button.addTarget(self, action: #selector(fetchLocation), for: .touchUpInside)
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(button.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        userLocationIsNotShowing()
    }
}

extension LocationViewController: LocationDisplayLogic {
    func userLocationIsNotShowing() {
        textLabel.text = "Press to see ur locaiton"
        button.backgroundColor = .cyan
        let conf = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(UIImage(systemName: "play", withConfiguration: conf), for: .normal)
        button.imageView?.tintColor = .white
    }
    
    func showUserLocaiton(_ vm: LocationModel.LocationFetch.ViewModel) {
        textLabel.text = vm.location
        button.backgroundColor = .red
        let conf = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(UIImage(systemName: "stop", withConfiguration: conf), for: .normal)
        button.imageView?.tintColor = .white
    }
    
    @objc
    func fetchLocation() {
        iterator?.toggleLocationService()
    }
}
