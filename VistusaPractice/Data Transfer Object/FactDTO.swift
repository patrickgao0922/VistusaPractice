//
//  FactDTO.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 13/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

struct FactDTO {
    var title:String?
    var rows:[RowDTO]
    init(title:String? = nil, rows:[RowDTO] = []) {
        self.title = title
        self.rows = rows
    }
}

struct RowDTO {
    var title:String?
    var description:String?
    var imageHref:String?
    init(title:String? = nil, description:String? = nil, imageHref:String? = nil) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
}
