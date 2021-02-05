//
//  AttributeTableViewCellViewModel.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation

class AttributeTableViewCellViewModel: BaseTableViewCellViewModel {
    var attribute : String
    var value : Int
    
    init(rowType: RowType, attribute: String) {
        self.attribute = attribute
        self.value = 5
        super.init(rowType: rowType)
    }
    
    
}
