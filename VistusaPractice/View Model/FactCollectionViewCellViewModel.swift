//
//  FactCollectionViewCellViewModel.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 14/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift
protocol CellViewModelDelegate {
    func reloadCell(at indexPath:IndexPath)
}
protocol FactCollectionViewCellViewModel:class {
    var title:String? {get}
    var delegate:CellViewModelDelegate? {get set}
    var description:String? {get}
    var image:Variable<UIImage?> {get}
     func downloadImage(at indexPath:IndexPath)
}

class FactCollectionViewCellViewModelImplementation:FactCollectionViewCellViewModel {
    
    var title:String?
    var description:String?
    fileprivate var imageHref:String?
    fileprivate var rowDTO:RowDTO
    fileprivate var disposeBag:DisposeBag = DisposeBag()
    fileprivate var imageDownloader:ImageDownloader
    var image:Variable<UIImage?>
    fileprivate var needToDownloadImage:Bool
    
    var delegate:CellViewModelDelegate?
    
    init(rowDTO:RowDTO,imageDownloader:ImageDownloader) {
        self.rowDTO = rowDTO
        self.title = rowDTO.title
        self.description = rowDTO.description
        self.imageHref = rowDTO.imageHref
        self.imageDownloader = imageDownloader
        image = Variable<UIImage?>(nil)
        
        if imageHref != nil {
            needToDownloadImage = true
        } else {
            needToDownloadImage = false
        }
    }
    
    func downloadImage(at indexPath:IndexPath) {
        if needToDownloadImage {
            needToDownloadImage = false
            if let imageHref = self.imageHref {
                imageDownloader.downloadImage(urlString: imageHref).subscribe { (single) in
                    switch single {
                    case .success(let path):
                        self.image.value = UIImage(contentsOfFile: path)
                        DispatchQueue.main.async {
                            self.delegate?.reloadCell(at: indexPath)
                        }
                        
                    case .error(_):
                        self.image.value = nil
                    }
                    }.disposed(by: disposeBag)
            }
        }
        
        
    }
}
