//
//  APIRouterTests.swift
//  VistusaPracticeTests
//
//  Created by Patrick Gao on 12/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire
@testable import VistusaPractice

class APIRouterTests:QuickSpec {
    override func spec() {
        it("Test Route") {
            let request = APIRouter.fact.urlRequest
            expect(request?.url?.absoluteString).to(equal("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"))
            expect(request?.httpMethod).to(equal("GET"))
        }
    }
}
