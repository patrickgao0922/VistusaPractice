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
    
    /// Fetch fact using API client and translate result into Fact DTO
    ///
    /// - Returns: Single Observable with element type of FactDTO
    func fetchFact() -> Single<FactDTO> {
        return apiClient.fetchFact().map { (factResponse) -> FactDTO in
            return self.translationLayer.translateToFactDTO(from: factResponse)
        }
    }
}
