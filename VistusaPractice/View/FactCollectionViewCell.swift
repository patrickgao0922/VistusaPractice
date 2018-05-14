//
//  FactCollectionViewCell.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 14/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import UIKit
import RxSwift

class FactCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    fileprivate var imageDownloadingSub:Disposable?
    
    fileprivate weak var viewModel:FactCollectionViewCellViewModel? = nil
    fileprivate var disposeBag:DisposeBag = DisposeBag()
    
    func config(with rowDTO:RowDTO, using viewModel:FactCollectionViewCellViewModel? = nil) {
        if let viewModel = viewModel {
            self.viewModel = viewModel
        }
        self.imageView.image = nil
        imageDownloadingSub?.dispose()
        setupObservables()
        startDownloadImage()
        
//        self.titleLabel.text = viewModel?.title
//        self.descriptionLabel.text = viewModel?.description
    }
    
    func startDownloadImage(){
        viewModel?.downloadImage()
    }
}

extension FactCollectionViewCell {
    func setupObservables() {
        imageDownloadingSub = viewModel?.image.asDriver().asObservable().skip(1).subscribe(onNext: { (image) in
            self.imageView.image = image
        })
        imageDownloadingSub?.disposed(by: disposeBag)
    }
}
