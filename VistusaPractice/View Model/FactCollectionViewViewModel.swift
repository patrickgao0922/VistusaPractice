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

protocol FactCollectionViewDelegate {
    func reloadCell(at indexPath: IndexPath)
}

protocol FactCollectionViewViewModel {
    var fact:Variable<FactDTO?> {get}
    var delegate:FactCollectionViewDelegate? {get set}
    func fetchFact()
    func addViewModel(forCellAtIndexPath indexPath:IndexPath, viewModel:FactCollectionViewCellViewModel)
    func obtainViewModel(forCellAtIndexPath indexPath:IndexPath) -> FactCollectionViewCellViewModel?
    func startDownloadImage(atPaths paths:[IndexPath])
    func imageSize(at indexPath:IndexPath) -> CGSize?
}

class FactCollectionViewViewModelImplementation:FactCollectionViewViewModel {
    
    fileprivate var modelLayer:FactModelLayer
    fileprivate var disposeBag:DisposeBag
    fileprivate var cellViewModels:[FactCollectionViewCellViewModel]
    
    var delegate: FactCollectionViewDelegate?
    
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
            viewModel.delegate = self
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
            cellViewModel.downloadImage(at: indexPath)
        }
    }
    
    /// Return size of image of a cell
    ///
    /// - Parameter indexPath: indexPath of the cell
    /// - Returns: image size
    func imageSize(at indexPath:IndexPath) -> CGSize? {
        var imageSize:CGSize? = nil
        if indexPath.row < cellViewModels.count {
            let cellViewModel = cellViewModels[indexPath.row]
            if let image = cellViewModel.image.value {
                imageSize = image.size
            }
        }
        return imageSize
    }
}

extension FactCollectionViewViewModelImplementation:CellViewModelDelegate {
    func reloadCell(at indexPath: IndexPath) {
        delegate?.reloadCell(at: indexPath)
    }
    
    
}

