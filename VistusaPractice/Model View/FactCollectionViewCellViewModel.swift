//
//  FactCollectionViewCellViewModel.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 14/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift

protocol FactCollectionViewCellViewModel:class {
    var title:String? {get}
    var description:String? {get}
    var image:Variable<UIImage?> {get}
    func downloadImage()
}

class FactCollectionViewCellViewModelImplementation:FactCollectionViewCellViewModel {
    var title:String?
    var description:String?
    fileprivate var imageHref:String?
    fileprivate var rowDTO:RowDTO
    var image:Variable<UIImage?>
    
    init(rowDTO:RowDTO) {
        self.rowDTO = rowDTO
        self.title = rowDTO.title
        self.description = rowDTO.description
        self.imageHref = rowDTO.imageHref
        image = Variable<UIImage?>(nil)
    }
    
    func downloadImage() {
        
    }
}
