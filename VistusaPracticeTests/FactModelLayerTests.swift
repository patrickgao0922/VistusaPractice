//
//  FactModelLayerTests.swift
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

class FactModelLayerTests:QuickSpec {
    override func spec() {
        let container: Container = Container()
        let dependencyRegistry:DependencyRegistry = DependencyRegistry(withContainer: container)
        let factModelLayer:FactModelLayer = dependencyRegistry.container.resolve(FactModelLayer.self)!
        
        it("Test fetchFact():") {
            let result = factModelLayer.fetchFact().toBlocking().materialize()
            switch result {
            case .completed(let factDTOs):
                expect(factDTOs[0].title).toNot(beNil())
                expect(factDTOs[0].title).to(equal("About Canada"))
                expect(factDTOs[0].rows.count).to(equal(14))
            case .failed(_, let error):
                fail()
            }
        }
    }
}
