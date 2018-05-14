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
    
    fileprivate weak var viewModel:FactCollectionViewCellViewModel? = nil
    
    func config(with rowDTO:RowDTO, using viewModel:FactCollectionViewCellViewModel? = nil) {
        if let viewModel = viewModel {
            self.viewModel = viewModel
        }
        
//        self.titleLabel.text = viewModel?.title
//        self.descriptionLabel.text = viewModel?.description
    }
}

extension FactCollectionViewCell {
    func setupObservables() {
        
    }
}
