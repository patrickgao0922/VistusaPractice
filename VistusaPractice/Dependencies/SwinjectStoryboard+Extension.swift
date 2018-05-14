//
//  SwinjectStoryboard+Extension.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 14/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc public class func setup() {
        if AppDelegate.dependencyRegistry == nil {
            AppDelegate.dependencyRegistry = DependencyRegistry(withContainer: defaultContainer)
        }
        
        let dependencyRegistry = AppDelegate.dependencyRegistry!
        
        

        
        
        /// Main entry of the storyboard
        func main() {
            //        Setup Dependency
            defaultContainer.storyboardInitCompleted(ViewController.self) { (r, vc) in
                let vm  = r.resolve(FactCollectionViewViewModel.self)!
                vc.config(viewModel: vm, cellMaker: dependencyRegistry.makeCollectionViewCell(collectionView:at:with:using:))
            }
            
        }
        
        
        main()
    }
}
