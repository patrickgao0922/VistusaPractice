//
//  TranslationLayer.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 13/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

protocol FactTranslationLayer {
    func translateToFactDTO(from row:FactResponse) -> FactDTO
    func translationToRowDTO(from faceResponse:Row) -> RowDTO
}

class FactTranslationLayerImplementation:FactTranslationLayer {
    
    /// Translate Row mapper object to Row DTO
    ///
    /// - Parameter row: Row mapper obtained from response
    /// - Returns: RowDTO result
    func translationToRowDTO(from row: Row) -> RowDTO {
        
        let rowDTO = RowDTO(title: row.title, description: row.description, imageHref: row.imageHref)
        return rowDTO
    }
    
    /// Translate Fact Mapper object to Fact DTO
    ///
    /// - Parameter factResponse: fact Response from response
    /// - Returns: fact DTO result
    func translateToFactDTO(from factResponse: FactResponse) -> FactDTO {
        var rowDTOs:[RowDTO] = []
        if factResponse.rows != nil {
            rowDTOs = factResponse.rows!.map({ (row) -> RowDTO in
                return translationToRowDTO(from: row)
            })
        }
        
        return FactDTO(title: factResponse.title, rows: rowDTOs)
    }
    
    
}
