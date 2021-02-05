//
//  BaseTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation


class BaseTableViewCellViewModel {
    var rowType : RowType
    
    init(rowType: RowType) {
        self.rowType = rowType
    }
}
