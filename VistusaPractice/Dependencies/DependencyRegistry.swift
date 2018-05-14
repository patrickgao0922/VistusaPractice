//
//  DependencyRegistry.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 13/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Swinject

class DependencyRegistry {
    var container:Container
    
    init(withContainer container:Container) {
        self.container = container
        registerDependencies()
        registerViewModel()
    }
    
    func registerDependencies() {
        container.register(APIClient.self) { r in
            APIClientImplementation()
        }
        
        container.register(FactTranslationLayer.self) { r in
            FactTranslationLayerImplementation()
        }
        
        container.register(FactModelLayer.self) { r in
            FactModelLayerImplementation(with: r.resolve(APIClient.self)!, translationLayer: r.resolve(FactTranslationLayer.self)!)
        }
        
        
    }
    
    func registerViewModel() {
        container.register(FactCollectionViewCellViewModel.self) { (r, rowDTO) in
            FactCollectionViewCellViewModelImplementation(rowDTO: rowDTO)
        }
        
        container.register(FactCollectionViewViewModel.self) { r in
            FactCollectionViewViewModelImplementation(withFactModelLayer: r.resolve(FactModelLayer.self)!)
        }
    }
}
