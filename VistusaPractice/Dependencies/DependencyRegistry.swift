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
    }
    
    func registerDependencies() {
        container.register(APIClient.self) { (r) in
            APIClientImplementation()
        }
        
        container.register(FactTranslationLayer.self) { r in
            FactTranslationLayerImplementation()
        }
    }
}
