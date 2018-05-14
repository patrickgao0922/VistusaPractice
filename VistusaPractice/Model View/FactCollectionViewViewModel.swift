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
}

class FactCollectionViewViewModelImplementation:FactCollectionViewViewModel {
    
    fileprivate var modelLayer:FactModelLayer
    fileprivate var disposeBag:DisposeBag
    
//    var cellViewModels:
    
    var fact:Variable<FactDTO?>
    init (withFactModelLayer modelLayer:FactModelLayer) {
        self.modelLayer = modelLayer
        disposeBag = DisposeBag()
        fact = Variable<FactDTO?>(nil)
    }
    
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
}
