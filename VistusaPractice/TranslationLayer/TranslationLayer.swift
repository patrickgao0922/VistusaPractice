//
//  TranslationLayer.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 13/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

protocol FactTranslationLayer {
    func translateToFactDTO(from:FactResponse) -> FactDTO
    func translationToRowDTO(from:Row) -> RowDTO
}

class FactTranslationLayerImplementation:FactTranslationLayer {
    
    func translationToRowDTO(from: Row) -> RowDTO {
        return RowDTO()
    }
    
    func translateToFactDTO(from: FactResponse) -> FactDTO {
        return FactDTO()
    }
    
    
}
