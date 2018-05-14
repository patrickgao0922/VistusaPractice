//
//  FactCollectionViewViewModelTests.swift
//  VistusaPracticeTests
//
//  Created by Patrick Gao on 14/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxBlocking
import Swinject
@testable import VistusaPractice

class FactCollectionViewViewModelTests:QuickSpec {
    override func spec() {
        let container: Container = Container()
        let dependencyRegistry:DependencyRegistry = DependencyRegistry(withContainer: container)
        let viewModel = dependencyRegistry.container.resolve(FactCollectionViewViewModel.self)
        
        it("Test fetch Fact") {
            
        }
    }
}
