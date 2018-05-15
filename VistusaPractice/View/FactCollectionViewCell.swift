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
    
    @IBOutlet var titleLabel: UILabel!
    fileprivate var imageDownloadingSub:Disposable?
    
    fileprivate var viewModel:FactCollectionViewCellViewModel? = nil
    fileprivate var disposeBag:DisposeBag = DisposeBag()
    
    func config(with rowDTO:RowDTO, using viewModel:FactCollectionViewCellViewModel? = nil) {
        self.titleLabel.sizeToFit()
        if let viewModel = viewModel {
            self.viewModel = viewModel
        }
        self.imageView.image = nil
        self.titleLabel.text = viewModel?.title
        imageDownloadingSub?.dispose()
        setupObservables()
    }
    
    func returnCellViewModel() -> FactCollectionViewCellViewModel{
        return viewModel!
    }
}

extension FactCollectionViewCell {
    func setupObservables() {
        imageDownloadingSub = viewModel?.image.asDriver().asObservable().subscribe(onNext: { (image) in
            self.imageView.image = image
        })
        imageDownloadingSub?.disposed(by: disposeBag)
    }
}
