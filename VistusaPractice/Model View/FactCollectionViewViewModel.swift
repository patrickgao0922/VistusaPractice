//
//  FactCollectionViewModelView.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 14/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

protocol FactCollectionViewViewModel {}

class FactCollectionViewViewModelImplementation:FactCollectionViewViewModel {
    
    fileprivate var modelLayer:FactModelLayer
    init (withFactModelLayer modelLayer:FactModelLayer) {
        self.modelLayer = modelLayer
    }
    
    func fetchFact() {
        
    }
}

//struct FactSection
