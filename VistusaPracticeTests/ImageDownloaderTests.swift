//
//  ImageDownloaderTests.swift
//  VistusaPracticeTests
//
//  Created by Patrick Gao on 14/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject
import Swinject
import RxBlocking
@testable import VistusaPractice

class ImageDownloaderTests:QuickSpec {
    override func spec() {
        let container:Container = Container()
        let dependencyRegistry:DependencyRegistry = DependencyRegistry(withContainer: container)
        let imageDownloader: ImageDownloader = dependencyRegistry.container.resolve(ImageDownloader.self)!
        
        it("Test download image") {
            let urlString = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
            let result = imageDownloader.downloadImage(urlString: urlString).toBlocking().materialize()
            
            switch result {
            case .completed(let paths):
                let image = UIImage(contentsOfFile: paths[0])
                expect(image).notTo(beNil())
            case .failed(_, let error):
                fail(error.localizedDescription)
            }
        }
    }
}
