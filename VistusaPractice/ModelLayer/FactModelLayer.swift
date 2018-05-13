//
//  FactModel.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 13/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift

protocol FactModelLayer {
    func fetchFact() -> Single<FactDTO>
}

class FactModelLayerImplementation:FactModelLayer {
    fileprivate var apiClient:APIClient
    fileprivate var translationLayer:FactTranslationLayer
    init(with apiClient:APIClient,translationLayer: FactTranslationLayer) {
        self.apiClient = apiClient
        self.translationLayer = translationLayer
    }
    
    func fetchFact() -> Single<FactDTO> {
        return apiClient.fetchFact().map { (factResponse) -> FactDTO in
            return FactDTO(title: nil, rows: [])
//            return self.translationLayer.translateToFactDTO(from: factResponse)
        }
    }
}
