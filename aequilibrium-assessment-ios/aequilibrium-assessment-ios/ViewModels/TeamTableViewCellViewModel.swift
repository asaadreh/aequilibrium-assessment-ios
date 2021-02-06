//
//  TeamTableViewCellViewModel.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation

class TeamTableViewCellViewModel: BaseTableViewCellViewModel {
    var isDecepticon = false
    
    override init(rowType: RowType) {
        super.init(rowType: rowType)
    }
    
    init(rowType: RowType, isDecepticon: Bool) {
        self.isDecepticon = isDecepticon
        super.init(rowType: rowType)
    }
}
