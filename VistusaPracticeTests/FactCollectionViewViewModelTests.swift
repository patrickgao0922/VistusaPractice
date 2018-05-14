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
import RxSwift
import Swinject
@testable import VistusaPractice

class FactCollectionViewViewModelTests:QuickSpec {
    override func spec() {
        let container: Container = Container()
        let dependencyRegistry:DependencyRegistry = DependencyRegistry(withContainer: container)
        let viewModel = dependencyRegistry.container.resolve(FactCollectionViewViewModel.self)!
        
        it("Test fetch Fact") {
            
            waitUntil(timeout: 5.0, action: { (done) in
                _ = viewModel.fact.asObservable().skip(1).subscribe(onNext: { (factDTO) in
                    expect(factDTO).notTo(beNil())
                    expect(factDTO!.title).to(equal("About Canada"))
                    done()
                })
                viewModel.fetchFact()
            })
            
        }
    }
}
