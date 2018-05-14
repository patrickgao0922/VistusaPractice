//
//  FactCollectionViewModelView.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 14/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FactCollectionViewViewModel {
    var fact:Variable<FactDTO?> {get}
    func fetchFact()
    func addViewModel(forCellAtIndexPath indexPath:IndexPath, viewModel:FactCollectionViewCellViewModel)
    func obtainViewModel(forCellAtIndexPath indexPath:IndexPath) -> FactCollectionViewCellViewModel?
    func startDownloadImage(atPaths paths:[IndexPath])
}

class FactCollectionViewViewModelImplementation:FactCollectionViewViewModel {
    
    fileprivate var modelLayer:FactModelLayer
    fileprivate var disposeBag:DisposeBag
    fileprivate var cellViewModels:[FactCollectionViewCellViewModel]
    
//    var cellViewModels:
    
    var fact:Variable<FactDTO?>
    init (withFactModelLayer modelLayer:FactModelLayer) {
        self.modelLayer = modelLayer
        disposeBag = DisposeBag()
        fact = Variable<FactDTO?>(nil)
        cellViewModels = []
    }
    
    /// Fetch latest fact
    func fetchFact() {
        modelLayer.fetchFact().subscribe { (single) in
            switch single {
            case .success(let factDTO):
                self.fact.value = factDTO
            case .error(_):
                break
            }
        }.disposed(by: disposeBag)
    }
    
    func addViewModel(forCellAtIndexPath indexPath:IndexPath, viewModel:FactCollectionViewCellViewModel) {
        if indexPath.row > cellViewModels.count-1 {
            cellViewModels.append(viewModel)
        }
    }
    
    func obtainViewModel(forCellAtIndexPath indexPath:IndexPath) -> FactCollectionViewCellViewModel? {
        if indexPath.row < cellViewModels.count {
            return cellViewModels[indexPath.row]
        }
        else {
            return nil
        }
    }
    
    
    func startDownloadImage(atPaths paths:[IndexPath]) {
        for indexPath in paths {
            let cellViewModel = cellViewModels[indexPath.row]
            cellViewModel.downloadImage()
        }
    }
    
    
}
