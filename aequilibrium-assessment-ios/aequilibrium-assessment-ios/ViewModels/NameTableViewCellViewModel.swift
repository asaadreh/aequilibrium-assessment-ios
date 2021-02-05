//
//  NameTableViewCellViewModel.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation

class NameTableViewCellViewModel: BaseTableViewCellViewModel {
    var placeHolder : String
    var name: String
    
    init(rowType: RowType, placeHolder: String) {
        self.name = ""
        self.placeHolder = placeHolder
        super.init(rowType: rowType)
    }
    
    
}

